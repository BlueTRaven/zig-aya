const std = @import("std");
const aya = @import("aya");
const data = @import("data.zig");

const ComponentInstance = data.ComponentInstance;

pub const Entity = struct {
    id: u8 = 0,
    name: [25:0]u8 = undefined,
    components: std.ArrayList(ComponentInstance),
    transform: Transform,
    sprite: ?Sprite = null,
    collider: ?Collider = null,

    pub fn init(id: u8, name: []const u8, position: aya.math.Vec2) Entity {
        var entity = Entity{
            .id = id,
            .components = std.ArrayList(ComponentInstance).init(aya.mem.allocator),
            .transform = .{ .pos = position },
        };
        aya.mem.copyZ(u8, &entity.name, name);
        return entity;
    }

    pub fn deinit(self: @This()) void {
        for (self.components.items) |*comp| comp.deinit();
        self.components.deinit();
    }

    pub fn addComponent(self: *@This(), component: ComponentInstance) void {
        self.components.append(component) catch unreachable;
    }

    pub fn transformMatrix(self: @This()) aya.math.Mat32 {
        // we definitely have a sprite if this is called so its safe to access it
        const t = self.transform;
        return aya.math.Mat32.initTransform(.{ .x = t.pos.x, .y = t.pos.y, .angle = aya.math.toRadians(t.rot), .sx = t.scale.x, .sy = t.scale.y, .ox = self.sprite.?.origin.x, .oy = self.sprite.?.origin.y });
    }
};

pub const Transform = struct {
    pos: aya.math.Vec2 = .{},
    rot: f32 = 0,
    scale: aya.math.Vec2 = .{ .x = 1, .y = 1 },
};

pub const Sprite = struct {
    tex: aya.gfx.Texture = undefined,
    origin: aya.math.Vec2 = .{},
};

pub const Collider = union(enum) {
    box: BoxCollider,
    circle: CircleCollider,
};

pub const BoxCollider = struct {
    offset: aya.math.Vec2 = .{},
    w: f32,
    h: f32,

    pub fn init(w: f32, h: f32) BoxCollider {
        return .{ .w = w, .h = h };
    }
};

pub const CircleCollider = struct {
    offset: aya.math.Vec2 = .{},
    r: f32,

    pub fn init(r: f32) CircleCollider {
        return .{ .r = r };
    }
};
