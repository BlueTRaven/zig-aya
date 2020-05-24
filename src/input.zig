const std = @import("std");
const sdl = @import("deps/sdl/sdl.zig");
const gfx = @import("gfx/gfx.zig");
const math = @import("math/math.zig");
const FixedList = @import("utils/fixed_list.zig").FixedList;

const released: u3 = 1; // true only the frame the key is released
const down: u3 = 2; // true the entire time the key is down
const pressed: u3 = 3; // only true if down this frame and not down the previous frame

pub const MouseButton = enum(usize) {
    left = 1,
    middle = 2,
    right = 3,
};

pub const Input = struct {
    keys: [@intCast(usize, @enumToInt(sdl.SDL_Scancode.SDL_NUM_SCANCODES))]u2 = [_]u2{0} ** @intCast(usize, @enumToInt(sdl.SDL_Scancode.SDL_NUM_SCANCODES)),
    dirty_keys: FixedList(i32, 10),
    mouse_buttons: [4]u2 = [_]u2{0} ** 4,
    dirty_mouse_buttons: FixedList(u2, 3),
    mouse_wheel_y: i32 = 0,
    mouse_rel_x: i32 = 0,
    mouse_rel_y: i32 = 0,
    window_scale: i32 = 0,
    res_scaler: gfx.ResolutionScaler = undefined,

    pub fn init(win_scale: f32) Input {
        return .{
            .dirty_keys = FixedList(i32, 10).init(),
            .dirty_mouse_buttons = FixedList(u2, 3).init(),
            .window_scale = @floatToInt(i32, win_scale),
            .res_scaler = gfx.getResolutionScaler(),
        };
    }

    /// clears any released keys
    pub fn newFrame(self: *Input) void {
        if (self.dirty_keys.len > 0) {
            var iter = self.dirty_keys.iter();
            while (iter.next()) |key| {
                const ukey = @intCast(usize, key);

                // guard against double key presses
                if (self.keys[ukey] > 0)
                    self.keys[ukey] -= 1;
            }
            self.dirty_keys.clear();
        }

        if (self.dirty_mouse_buttons.len > 0) {
            var iter = self.dirty_mouse_buttons.iter();
            while (iter.next()) |button| {

                // guard against double mouse presses
                if (self.mouse_buttons[button] > 0)
                    self.mouse_buttons[button] -= 1;
            }
            self.dirty_mouse_buttons.clear();
        }

        self.mouse_wheel_y = 0;
        self.mouse_rel_x = 0;
        self.mouse_rel_y = 0;
    }

    pub fn handleEvent(self: *Input, event: *sdl.SDL_Event) void {
        switch (event.type) {
            sdl.SDL_KEYDOWN, sdl.SDL_KEYUP => self.handleKeyboardEvent(&event.key),
            sdl.SDL_MOUSEBUTTONDOWN, sdl.SDL_MOUSEBUTTONUP => self.handleMouseEvent(&event.button),
            sdl.SDL_MOUSEWHEEL => self.mouse_wheel_y = event.wheel.y,
            sdl.SDL_MOUSEMOTION => {
                self.mouse_rel_x = event.motion.xrel;
                self.mouse_rel_y = event.motion.yrel;
            },
            sdl.SDL_CONTROLLERAXISMOTION => std.debug.warn("SDL_CONTROLLERAXISMOTION\n", .{}),
            sdl.SDL_CONTROLLERBUTTONDOWN, sdl.SDL_CONTROLLERBUTTONUP => std.debug.warn("SDL_CONTROLLERBUTTONUP/DOWN\n", .{}),
            sdl.SDL_CONTROLLERDEVICEADDED, sdl.SDL_CONTROLLERDEVICEREMOVED => std.debug.warn("SDL_CONTROLLERDEVICEADDED/REMOVED\n", .{}),
            sdl.SDL_CONTROLLERDEVICEREMAPPED => std.debug.warn("SDL_CONTROLLERDEVICEREMAPPED\n", .{}),
            else => {},
        }
    }

    fn handleKeyboardEvent(self: *Input, evt: *sdl.SDL_KeyboardEvent) void {
        const scancode = @enumToInt(evt.keysym.scancode);
        self.dirty_keys.append(scancode);

        if (evt.state == 0) {
            self.keys[@intCast(usize, scancode)] = released;
        } else {
            self.keys[@intCast(usize, scancode)] = pressed;
        }

        // std.debug.warn("kb: {s}: {}\n", .{ sdl.SDL_GetKeyName(evt.keysym.sym), evt });
    }

    fn handleMouseEvent(self: *Input, evt: *sdl.SDL_MouseButtonEvent) void {
        self.dirty_mouse_buttons.append(@intCast(u2, evt.button));
        if (evt.state == 0) {
            self.mouse_buttons[@intCast(usize, evt.button)] = released;
        } else {
            self.mouse_buttons[@intCast(usize, evt.button)] = pressed;
        }

        // std.debug.warn("mouse: {}\n", .{evt});
    }

    /// only true if down this frame and not down the previous frame
    pub fn keyPressed(self: Input, scancode: sdl.SDL_Scancode) bool {
        return self.keys[@intCast(usize, @enumToInt(scancode))] == pressed;
    }

    /// true the entire time the key is down
    pub fn keyDown(self: Input, scancode: sdl.SDL_Scancode) bool {
        return self.keys[@intCast(usize, @enumToInt(scancode))] > released;
    }

    /// true only the frame the key is released
    pub fn keyUp(self: Input, scancode: sdl.SDL_Scancode) bool {
        return self.keys[@intCast(usize, @enumToInt(scancode))] == released;
    }

    /// only true if down this frame and not down the previous frame
    pub fn mousePressed(self: Input, button: MouseButton) bool {
        return self.mouse_buttons[@enumToInt(button)] == pressed;
    }

    /// true the entire time the button is down
    pub fn mouseDown(self: Input, button: MouseButton) bool {
        return self.mouse_buttons[@enumToInt(button)] > released;
    }

    /// true only the frame the button is released
    pub fn mouseUp(self: Input, button: MouseButton) bool {
        return self.mouse_buttons[@enumToInt(button)] == released;
    }

    pub fn mouseWheel(self: Input) i32 {
        return self.mouse_wheel_y;
    }

    pub fn mousePos(self: Input, x: *i32, y: *i32) void {
        var xc: c_int = undefined;
        var yc: c_int = undefined;
        _ = sdl.SDL_GetMouseState(&xc, &yc);
        x.* = @intCast(i32, xc) * self.window_scale;
        y.* = @intCast(i32, yc) * self.window_scale;
    }

    // gets the scaled mouse position based on the currently bound render texture scale and offset
    // as calcuated in OffscreenPass. scale should be scale and offset_n is the calculated x, y value.
    pub fn mousePosScaled(self: Input, x: *i32, y: *i32) void {
        self.mousePos(x, y);

        const xf = @intToFloat(f32, x.*) - @intToFloat(f32, self.res_scaler.x);
        const yf = @intToFloat(f32, y.*) - @intToFloat(f32, self.res_scaler.y);
        x.* = @floatToInt(i32, xf / self.res_scaler.scale);
        y.* = @floatToInt(i32, yf / self.res_scaler.scale);
    }

    pub fn mousePosScaledVec(self: Input) math.Vec2 {
        var x: i32 = undefined;
        var y: i32 = undefined;
        self.mousePosScaled(&x, &y);
        return .{ .x = @intToFloat(f32, x), .y = @intToFloat(f32, y) };
    }

    pub fn mouseRelMotion(self: Input, x: *i32, y: *i32) void {
        x.* = self.mouse_rel_x;
        y.* = self.mouse_rel_y;
    }
};

test "test input" {
    var input = Input.init(1);
    _ = input.keyPressed(.SDL_SCANCODE_A);
    _ = input.mousePressed(.left);
    _ = input.mouseWheel();

    var x: i32 = undefined;
    var y: i32 = undefined;
    _ = input.mousePosScaled(&x, &y);

    _ = input.mousePosScaledVec();
    input.mouseRelMotion(&x, &y);
}
