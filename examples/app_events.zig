const std = @import("std");
const aya = @import("aya");
const ecs = @import("ecs");
const phases = aya.phases;

const App = aya.App;
const EventReader = aya.EventReader;
const EventWriter = aya.EventWriter;

pub const Resource = struct { num: u64 };

const SuperEvent = struct {};

pub fn main() !void {
    std.debug.print("\n", .{});

    App.init()
        .addEvent(SuperEvent)
        .addSystem(phases.startup, WriteEventSystem)
        .addSystem(phases.first, ReadEventSystem)
        .run();
}

const WriteEventSystem = struct {
    pub fn run(events: EventWriter(SuperEvent)) void {
        std.debug.print("-- EmitEventSystem\n", .{});
        events.sendDefault();
    }
};

const ReadEventSystem = struct {
    pub fn run(events: EventReader(SuperEvent)) void {
        std.debug.print("-- ReadEventSystem. total events: {}\n", .{events.get().len});

        for (events.get()) |evt| {
            std.debug.print("-- --- read event: {}\n", .{evt});
        }
    }
};
