const std = @import("std");
const sdl = @import("sdl");
const metal = @import("metal");
const sokol = @import("sokol");
const aya = @import("../aya.zig");

const App = aya.App;
const Window = aya.Window;
const Res = aya.Res;

pub const ClearColor = struct {
    r: f32 = 0.8,
    g: f32 = 0.2,
    b: f32 = 0.3,
    a: f32 = 1,
};

pub const SokolPlugin = struct {
    pub fn build(_: SokolPlugin, app: *App) void {
        const window = app.world.resources.get(Window).?;
        metal.mu_create_metal_layer(window.sdl_window);

        sokol.gfx.setup(.{
            .context = .{
                .metal = .{
                    .device = metal.mu_get_metal_device(window.sdl_window),
                    .renderpass_descriptor_cb = metal.mu_get_render_pass_descriptor,
                    .drawable_cb = metal.mu_get_drawable,
                },
            },
        });

        _ = app
            .insertResource(ClearColor{})
            .addSystems(aya.Last, RenderClear);
    }
};

const RenderClear = struct {
    pub fn run(window_res: Res(Window), clear_color_res: Res(ClearColor)) void {
        const window = window_res.getAssertExists();
        const clear_color = clear_color_res.getAssertExists();

        var pass_action = sokol.gfx.PassAction{};
        pass_action.colors[0] = .{
            .load_action = .CLEAR,
            .clear_value = .{ .r = clear_color.r, .g = clear_color.g, .b = clear_color.b, .a = clear_color.a },
        };

        const size = window.sizeInPixels();
        sokol.gfx.beginDefaultPass(pass_action, size.w, size.h);
        sokol.gfx.endPass();
        sokol.gfx.commit();
    }
};
