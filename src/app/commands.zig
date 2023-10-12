const std = @import("std");
const aya = @import("../aya.zig");
const c = @import("../ecs/mod.zig").c;
const app = @import("mod.zig");

const systems = @import("systems.zig");
const assertMsg = aya.meta.assertMsg;

const Entity = aya.Entity;

pub const Commands = struct {
    ecs: *c.ecs_world_t,

    pub fn init(ecs: *c.ecs_world_t) Commands {
        return .{ .ecs = ecs };
    }

    pub fn pause(self: Commands, paused: bool) void {
        if (!paused) {
            self.removeAll(systems.SystemPaused);
            return;
        }

        var filter_desc = c.ecs_filter_desc_t{};
        filter_desc.terms[0].id = c.EcsSystem;
        filter_desc.terms[0].inout = c.EcsInOutNone;
        filter_desc.terms[0].inout = c.EcsInOutNone;
        filter_desc.terms[1].id = self.ecs.componentId(systems.SystemSort); // match only systems in the core pipeline
        filter_desc.terms[1].inout = c.EcsIn;
        filter_desc.terms[2].id = self.ecs.componentId(systems.RunWhenPaused); // skip RunWhenPaused systems
        filter_desc.terms[2].inout = c.EcsInOutNone;
        filter_desc.terms[2].oper = c.EcsNot;
        filter_desc.terms[3].id = c.EcsDisabled; // make sure we match disabled systems
        filter_desc.terms[3].inout = c.EcsInOutNone;
        filter_desc.terms[3].oper = c.EcsOptional;

        const pause_filter = c.ecs_filter_init(self.ecs, &filter_desc);
        defer c.ecs_filter_fini(pause_filter);

        var it = c.ecs_filter_iter(self.ecs, pause_filter);
        while (c.ecs_filter_next(&it)) {
            var i: usize = 0;
            while (i < it.count) : (i += 1) {
                _ = c.ecs_add_id(self.ecs, it.entities[i], self.ecs.componentId(systems.SystemPaused));
            }
        }
    }

    // Entities
    pub fn entity(self: Commands, id: u64) EntityCommands {
        return .{ .entity = Entity.init(self.ecs, id) };
    }

    /// accepts a tuple or single instance that contains any of: component type, component instance, tag, tag id, pair tuple,
    /// bundle type, bundle instance, name ([]const u8)
    pub fn spawn(self: Commands, args: anytype) EntityCommands {
        const ti = @typeInfo(@TypeOf(args));
        const tuple = if (ti == .Struct and ti.Struct.is_tuple) args else .{args};

        var desc = c.ecs_entity_desc_t{};

        var i: usize = 0;
        inline for (tuple) |obj| {
            const id_ti = @typeInfo(@TypeOf(obj));
            const is_bundle = (@TypeOf(obj) == type and @hasDecl(obj, "is_bundle")) or (id_ti == .Struct and @hasDecl(@TypeOf(obj), "is_bundle"));

            if (comptime std.meta.trait.isTuple(@TypeOf(obj))) {
                assertMsg(obj.len == 2, "Value of type {s} must be a tuple with 2 elements to be a pair", .{@typeName(@TypeOf(obj))});
                desc.add[i] = self.ecs.pair(obj[0], obj[1]);
                i += 1;
            } else if (is_bundle) {
                // bulk-add all bundle types. we'll set them after creating the entity
                const bundle_type = if (id_ti == .Type) obj else @TypeOf(obj);
                inline for (std.meta.fields(bundle_type)) |field| {
                    desc.add[i] = self.ecs.componentId(field.type);
                    i += 1;
                }
            } else if (id_ti == .Struct) {
                desc.add[i] = self.ecs.componentId(@TypeOf(obj));
                i += 1;
            } else if (@TypeOf(obj) == type) {
                desc.add[i] = self.ecs.componentId(obj);
                i += 1;
            } else if (@TypeOf(obj) == u64) {
                desc.add[i] = obj;
                i += 1;
            } else if (comptime std.meta.trait.isZigString(@TypeOf(obj))) {
                desc.name = obj;
            } else {
                @panic("attempting to add unhandled type" ++ @typeName(@TypeOf(obj)));
            }
        }

        const entity_commands = EntityCommands{ .entity = Entity.init(self.ecs, c.ecs_entity_init(self.ecs, &desc)) };

        // loop again and set any struct or bundle values
        inline for (tuple) |obj| {
            const id_ti = @typeInfo(@TypeOf(obj));
            const is_bundle = (@TypeOf(obj) == type and @hasDecl(obj, "is_bundle")) or (id_ti == .Struct and @hasDecl(@TypeOf(obj), "is_bundle"));

            if (is_bundle) {
                _ = entity_commands.insert(obj);
            } else if (id_ti == .Struct) {
                _ = entity_commands.insert(obj);
            }
        }

        return entity_commands;
    }

    pub fn spawnEmpty(self: Commands) EntityCommands {
        return .{ .entity = Entity.init(self.ecs, c.ecs_new_id(self.ecs)) };
    }

    pub fn newId(self: Commands) u64 {
        return c.ecs_new_id(self.ecs);
    }

    pub fn newEntityNamed(self: Commands, name: [*c]const u8) Entity {
        var desc = c.ecs_entity_desc_t{ .name = name };
        return Entity.init(self.ecs, c.ecs_entity_init(self.ecs, &desc));
    }

    // Resources
    pub fn initResource(self: Commands, comptime T: type) Commands {
        _ = T;
        // _ = self.resources.initResource(T);
        return self;
    }

    pub fn insertResource(self: Commands, resource: anytype) Commands {
        _ = resource;
        // self.resources.insert(resource);
        return self;
    }

    pub fn removeResource(self: Commands, comptime T: type) Commands {
        _ = T;
        // self.resources.remove(T);
        return self;
    }

    /// deletes all entities with the component
    pub fn deleteWith(self: Commands, comptime T: type) void {
        c.ecs_delete_with(self.ecs, self.ecs.componentId(T));
    }

    /// remove all instances of the specified component
    pub fn removeAll(self: Commands, comptime T: type) void {
        c.ecs_remove_all(self.ecs, self.ecs.componentId(T));
    }

    /// Filter, Query, System (need Term and Rules)
    /// creates a Filter using the passed in struct
    pub fn filter(self: Commands, comptime Components: type) aya.Filter(Components) {
        return self.ecs.filter(Components);
    }

    /// creates a Query using the passed in struct
    pub fn query(self: Commands, comptime Components: type) aya.Query(Components) {
        return self.ecs.query(Components);
    }

    // Systems
    /// registers a system that is not put in any phase and will only run when runSystem is called.
    pub fn registerSystem(self: Commands, comptime T: type) u64 {
        const id = self.ecs.newId();

        const deferred = aya.tmp_allocator.create(DeferredCreateSystem) catch unreachable;
        deferred.* = DeferredCreateSystem.init(T, id);
        c.ecs_run_post_frame(self.ecs, DeferredCreateSystem.createSystemPostFrame, deferred);

        return id;
    }

    /// runs a system after the current schedule completes
    pub fn runSystem(self: Commands, system: u64) void {
        _ = c.ecs_run(self.ecs, system, 0, null);
    }
};

pub const EntityCommands = struct {
    entity: Entity,

    /// accepts a tuple or single instance that contains any of: component type, component instance, tag type, tag id, pair tuple,
    /// bundle type, bundle instance, name ([]const u8)
    pub fn insert(self: EntityCommands, args: anytype) EntityCommands {
        const ti = @typeInfo(@TypeOf(args));

        const tuple = if (ti == .Struct and ti.Struct.is_tuple) args else .{args};

        inline for (tuple) |obj| {
            const id_ti = @typeInfo(@TypeOf(obj));
            const is_bundle = (@TypeOf(obj) == type and @hasDecl(obj, "is_bundle")) or (id_ti == .Struct and @hasDecl(@TypeOf(obj), "is_bundle"));

            if (comptime std.meta.trait.isTuple(@TypeOf(obj))) {
                assertMsg(obj.len == 2, "Value of type {s} must be a tuple with 2 elements to be a pair", .{@typeName(@TypeOf(obj))});
                self.entity.addPair(obj[0], obj[1]);
            } else if (is_bundle) {
                const bundle_type = if (id_ti == .Type) obj else @TypeOf(obj);

                if (ti == .Type) {
                    // loop and set any components that have default values
                    inline for (std.meta.fields(bundle_type)) |field| {
                        if (field.default_value) |ptr| {
                            const comp = @as(*const field.type, @ptrCast(@alignCast(ptr)));
                            self.entity.set(comp);
                        } else {
                            self.entity.add(field.type);
                        }
                    }
                } else {
                    // loop and set any components using the field value
                    inline for (std.meta.fields(bundle_type)) |field| {
                        self.entity.set(@field(obj, field.name));
                    }
                }
            } else if (id_ti == .Struct) {
                self.entity.set(obj);
            } else if (@TypeOf(obj) == u64 or @TypeOf(obj) == type) {
                self.entity.add(obj);
            } else if (comptime std.meta.trait.isZigString(@TypeOf(obj))) {
                self.entity.setName(obj);
            } else {
                @panic("attempting to add unhandled type" ++ @typeName(@TypeOf(obj)));
            }
        }

        return self;
    }

    fn insertSingle(self: EntityCommands, component: anytype) void {
        switch (@TypeOf(component)) {
            type, u64 => self.entity.add(component),
            else => {
                std.debug.assert(@typeInfo(@TypeOf(component)) == .Pointer or @typeInfo(@TypeOf(component)) == .Struct);
                self.entity.set(component);
            },
        }
    }

    fn insertBundle(self: EntityCommands, bundle: anytype) void {
        const ti = @typeInfo(@TypeOf(bundle));
        const bundle_type = if (ti == .Type) bundle else @TypeOf(bundle);

        if (ti == .Type) {
            // loop and set any components that have default values
            inline for (std.meta.fields(bundle)) |field| {
                if (field.default_value) |ptr| {
                    const comp = @as(*const field.type, @ptrCast(@alignCast(ptr)));
                    self.entity.set(comp);
                } else {
                    self.entity.add(field.type);
                }
            }
        } else {
            // loop and set any components using the field value
            inline for (std.meta.fields(bundle_type)) |field| {
                self.entity.set(@field(bundle, field.name));
            }
        }
    }

    pub fn remove(self: EntityCommands, id_or_type: anytype) EntityCommands {
        self.entity.remove(id_or_type);
        return self;
    }

    pub fn despawn(self: EntityCommands) void {
        self.entity.delete();
    }
};

pub fn tupleOrSingleArgToSlice(components: anytype) void {
    if (@typeInfo(@TypeOf(components)) == .Struct and @typeInfo(@TypeOf(components)).Struct.is_tuple) {
        return components;
    }
}

const DeferredCreateSystem = struct {
    id: u64,
    createSystemFn: *const fn (*DeferredCreateSystem, *c.ecs_world_t) void,

    pub fn init(comptime T: type, id: u64) DeferredCreateSystem {
        return .{
            .id = id,
            .createSystemFn = struct {
                fn createSystemFn(self: *DeferredCreateSystem, ecs: *c.ecs_world_t) void {
                    _ = systems.addSystemToEntity(ecs, self.id, 0, T);
                }
            }.createSystemFn,
        };
    }

    fn createSystemPostFrame(world: ?*c.ecs_world_t, ctx: ?*anyopaque) callconv(.C) void {
        const deferred = @as(*DeferredCreateSystem, @ptrFromInt(@intFromPtr(ctx.?)));
        deferred.createSystemFn(deferred, world.?);
    }
};
