const std = @import("std");

pub usingnamespace @import("app.zig");
pub usingnamespace @import("resources.zig");
pub usingnamespace @import("world.zig");
pub usingnamespace @import("commands.zig");
pub usingnamespace @import("event.zig");

const state = @import("state.zig");
pub const State = state.State;
pub const NextState = state.NextState;

const locals = @import("locals.zig");
pub const Local = locals.Local;

pub const DefaultPlugins = struct {
    const App = @import("app.zig").App;
    const WindowPlugin = @import("../window/mod.zig").WindowPlugin;
    const AssetPlugin = @import("../asset/mod.zig").AssetPlugin;

    window: ?WindowPlugin = .{},
    asset: ?AssetPlugin = .{},

    pub fn init() DefaultPlugins {
        return .{};
    }

    pub fn set(self: DefaultPlugins, plugin: anytype) DefaultPlugins {
        var dupe = self;
        const T = @TypeOf(plugin);
        inline for (std.meta.fields(DefaultPlugins)) |field| {
            if (std.meta.Child(field.type) == T) {
                @field(dupe, field.name) = plugin;
                return dupe;
            }
        }

        @panic("attempted to set a plugin that doesnt exist: " ++ @typeName(@TypeOf(plugin)));
    }

    pub fn disable(self: DefaultPlugins, comptime T: type) DefaultPlugins {
        var dupe = self;
        inline for (std.meta.fields(DefaultPlugins)) |field| {
            if (std.meta.Child(field.type) == T) {
                @field(dupe, field.name) = null;
                return dupe;
            }
        }

        @panic("attempted to disable a plugin that doesnt exist: " ++ @typeName(T));
    }
};
