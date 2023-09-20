const std = @import("std");
const ecs = @import("ecs");
const flecs = ecs.c;
const q = ecs.queries;

const Timeout = struct {
    value: f32,
};

const ExpireCallback = struct {
    timeout: *Timeout,
    pub const name = "Expire";
    pub const run = expire;
};

// System that deletes an entity after a timeout expires
fn expire(it: *ecs.Iterator(ExpireCallback)) void {
    while (it.next()) |components| {
        components.timeout.value -= it.iter.delta_time;
        if (components.timeout.value <= 0) {
            // When deleting the entity, use the world provided by the iterator.

            // To make sure that the storage doesn't change while a system is
            // iterating entities, and multiple threads can safely access the
            // data, mutations (like a delete) are added to a command queue and
            // executed when it's safe to do so.

            // A system should not use the world pointer that is provided by the
            // ecs_init function, as this will throw an error that the world is
            // in readonly mode (try replacing it->world with it->real_world).
            std.log.debug("Expire: {s} deleted!", .{it.entity().getName()});
            it.entity().delete();
        }
    }
}

const PrintExpireCallback = struct {
    timeout: *const Timeout,

    pub const name = "PrintExpire";
    pub const run = printExpire;
};

// System that prints remaining expiry time
fn printExpire(it: *ecs.Iterator(PrintExpireCallback)) void {
    while (it.next()) |components| {
        std.log.debug("PrintExpire: {s} has {d} seconds left", .{ it.entity().getName(), components.timeout.value });
    }
}

const ObserverCallback = struct {
    timeout: *const Timeout,

    pub const name = "Expired";
    pub const run = expired;
};

// Observer that triggers when the component is actually removed
fn expired(it: *ecs.Iterator(ObserverCallback)) void {
    while (it.next()) |_| {
        std.log.debug("Expired: {s} actually deleted", .{it.entity().getName()});
    }
}

pub fn main() !void {
    var world = ecs.Ecs.init();

    world.system(ExpireCallback, flecs.EcsOnUpdate);
    world.system(PrintExpireCallback, flecs.EcsOnUpdate);
    world.observer(ObserverCallback, flecs.EcsOnRemove);

    const e = world.newEntityWithName("MyEntity");
    e.set(&Timeout{ .value = 3 });

    world.setTargetFps(1);

    var progress: bool = true;
    while (progress) {
        world.progress(0);

        if (!e.isAlive()) break;
    }
}
