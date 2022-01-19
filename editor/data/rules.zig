const std = @import("std");
const aya = @import("aya");

const AutoTilemapLayer = @import("root").layers.AutoTilemapLayer;

pub const RuleSet = struct {
    seed: u64 = 0,
    rules: std.ArrayList(Rule),

    pub fn init() RuleSet {
        return .{ .rules = std.ArrayList(Rule).init(aya.mem.allocator) };
    }

    pub fn deinit(self: RuleSet) void {
        self.rules.deinit();
    }

    pub fn addRule(self: *RuleSet) void {
        self.rules.append(Rule.init()) catch unreachable;
    }

    pub fn getNextAvailableGroup(self: RuleSet, layer: *AutoTilemapLayer, name: []const u8) u8 {
        var group: u8 = 0;
        for (self.rules.items) |rule| {
            group = std.math.max(group, rule.group);
        }
        layer.ruleset_groups.put(group + 1, aya.mem.allocator.dupe(u8, name) catch unreachable) catch unreachable;
        return group + 1;
    }

    /// adds the Rules required for a nine-slice with index being the top-left element of the nine-slice
    pub fn addNinceSliceRules(self: *RuleSet, map: *AutoTilemapLayer, name_prefix: []const u8, index: usize) void {
        const selected_brush_index = map.brushset.selected.value;
        const tiles_per_row = map.tileset.tiles_per_row;
        const x = @mod(index, tiles_per_row);
        const y = @divTrunc(index, tiles_per_row);
        const group = self.getNextAvailableGroup(map, name_prefix);

        var rule = Rule.init();
        rule.group = group;
        const tl_name = std.mem.concat(aya.mem.tmp_allocator, u8, &[_][]const u8{ name_prefix, "-tl" }) catch unreachable;
        std.mem.copy(u8, &rule.name, tl_name);
        rule.get(1, 2).negate(selected_brush_index + 1);
        rule.get(2, 1).negate(selected_brush_index + 1);
        rule.get(2, 2).require(selected_brush_index + 1);
        rule.toggleSelected(@intCast(u8, x + y * tiles_per_row));
        self.rules.append(rule) catch unreachable;

        rule = Rule.init();
        rule.group = group;
        const tr_name = std.mem.concat(aya.mem.tmp_allocator, u8, &[_][]const u8{ name_prefix, "-tr" }) catch unreachable;
        std.mem.copy(u8, &rule.name, tr_name);
        rule.get(3, 2).negate(selected_brush_index + 1);
        rule.get(2, 1).negate(selected_brush_index + 1);
        rule.get(2, 2).require(selected_brush_index + 1);
        rule.toggleSelected(@intCast(u8, x + 2 + y * tiles_per_row));
        self.rules.append(rule) catch unreachable;

        rule = Rule.init();
        rule.group = group;
        const bl_name = std.mem.concat(aya.mem.tmp_allocator, u8, &[_][]const u8{ name_prefix, "-bl" }) catch unreachable;
        std.mem.copy(u8, &rule.name, bl_name);
        rule.get(1, 2).negate(selected_brush_index + 1);
        rule.get(2, 3).negate(selected_brush_index + 1);
        rule.get(2, 2).require(selected_brush_index + 1);
        rule.toggleSelected(@intCast(u8, x + (y + 2) * tiles_per_row));
        self.rules.append(rule) catch unreachable;

        rule = Rule.init();
        rule.group = group;
        const br_name = std.mem.concat(aya.mem.tmp_allocator, u8, &[_][]const u8{ name_prefix, "-br" }) catch unreachable;
        std.mem.copy(u8, &rule.name, br_name);
        rule.get(2, 3).negate(selected_brush_index + 1);
        rule.get(3, 2).negate(selected_brush_index + 1);
        rule.get(2, 2).require(selected_brush_index + 1);
        rule.toggleSelected(@intCast(u8, x + 2 + (y + 2) * tiles_per_row));
        self.rules.append(rule) catch unreachable;

        rule = Rule.init();
        rule.group = group;
        const t_name = std.mem.concat(aya.mem.tmp_allocator, u8, &[_][]const u8{ name_prefix, "-t" }) catch unreachable;
        std.mem.copy(u8, &rule.name, t_name);
        rule.get(2, 1).negate(selected_brush_index + 1);
        rule.get(2, 2).require(selected_brush_index + 1);
        rule.toggleSelected(@intCast(u8, x + 1 + y * tiles_per_row));
        self.rules.append(rule) catch unreachable;

        rule = Rule.init();
        rule.group = group;
        const b_name = std.mem.concat(aya.mem.tmp_allocator, u8, &[_][]const u8{ name_prefix, "-b" }) catch unreachable;
        std.mem.copy(u8, &rule.name, b_name);
        rule.get(2, 3).negate(selected_brush_index + 1);
        rule.get(2, 2).require(selected_brush_index + 1);
        rule.toggleSelected(@intCast(u8, x + 1 + (y + 2) * tiles_per_row));
        self.rules.append(rule) catch unreachable;

        rule = Rule.init();
        rule.group = group;
        const l_name = std.mem.concat(aya.mem.tmp_allocator, u8, &[_][]const u8{ name_prefix, "-l" }) catch unreachable;
        std.mem.copy(u8, &rule.name, l_name);
        rule.get(1, 2).negate(selected_brush_index + 1);
        rule.get(2, 2).require(selected_brush_index + 1);
        rule.toggleSelected(@intCast(u8, x + (y + 1) * tiles_per_row));
        self.rules.append(rule) catch unreachable;

        rule = Rule.init();
        rule.group = group;
        const r_name = std.mem.concat(aya.mem.tmp_allocator, u8, &[_][]const u8{ name_prefix, "-r" }) catch unreachable;
        std.mem.copy(u8, &rule.name, r_name);
        rule.get(3, 2).negate(selected_brush_index + 1);
        rule.get(2, 2).require(selected_brush_index + 1);
        rule.toggleSelected(@intCast(u8, (x + 2) + (y + 1) * tiles_per_row));
        self.rules.append(rule) catch unreachable;

        rule = Rule.init();
        rule.group = group;
        const c_name = std.mem.concat(aya.mem.tmp_allocator, u8, &[_][]const u8{ name_prefix, "-c" }) catch unreachable;
        std.mem.copy(u8, &rule.name, c_name);
        rule.get(2, 2).require(selected_brush_index + 1);
        rule.toggleSelected(@intCast(u8, x + 1 + (y + 1) * tiles_per_row));
        self.rules.append(rule) catch unreachable;
    }

    pub fn addInnerFourRules(self: *RuleSet, map: *AutoTilemapLayer, name_prefix: []const u8, index: usize) void {
        const selected_brush_index = map.brushset.selected.value;
        const tiles_per_row = map.tileset.tiles_per_row;
        const x = @mod(index, tiles_per_row);
        const y = @divTrunc(index, tiles_per_row);
        const group = self.getNextAvailableGroup(map, name_prefix);

        var rule = Rule.init();
        rule.group = group;
        const tl_name = std.mem.concat(aya.mem.tmp_allocator, u8, &[_][]const u8{ name_prefix, "-tl" }) catch unreachable;
        std.mem.copy(u8, &rule.name, tl_name);
        rule.get(1, 1).negate(selected_brush_index + 1);
        rule.get(1, 2).require(selected_brush_index + 1);
        rule.get(2, 1).require(selected_brush_index + 1);
        rule.get(2, 2).require(selected_brush_index + 1);
        rule.toggleSelected(@intCast(u8, x + y * tiles_per_row));
        self.rules.append(rule) catch unreachable;

        rule = Rule.init();
        rule.group = group;
        const tr_name = std.mem.concat(aya.mem.tmp_allocator, u8, &[_][]const u8{ name_prefix, "-tr" }) catch unreachable;
        std.mem.copy(u8, &rule.name, tr_name);
        rule.get(3, 1).negate(selected_brush_index + 1);
        rule.get(3, 2).require(selected_brush_index + 1);
        rule.get(2, 1).require(selected_brush_index + 1);
        rule.get(2, 2).require(selected_brush_index + 1);
        rule.toggleSelected(@intCast(u8, x + 1 + y * tiles_per_row));
        self.rules.append(rule) catch unreachable;

        rule = Rule.init();
        rule.group = group;
        const bl_name = std.mem.concat(aya.mem.tmp_allocator, u8, &[_][]const u8{ name_prefix, "-bl" }) catch unreachable;
        std.mem.copy(u8, &rule.name, bl_name);
        rule.get(1, 2).require(selected_brush_index + 1);
        rule.get(2, 3).require(selected_brush_index + 1);
        rule.get(2, 2).require(selected_brush_index + 1);
        rule.get(1, 3).negate(selected_brush_index + 1);
        rule.toggleSelected(@intCast(u8, x + (y + 1) * tiles_per_row));
        self.rules.append(rule) catch unreachable;

        rule = Rule.init();
        rule.group = group;
        const br_name = std.mem.concat(aya.mem.tmp_allocator, u8, &[_][]const u8{ name_prefix, "-br" }) catch unreachable;
        std.mem.copy(u8, &rule.name, br_name);
        rule.get(2, 3).require(selected_brush_index + 1);
        rule.get(3, 2).require(selected_brush_index + 1);
        rule.get(2, 2).require(selected_brush_index + 1);
        rule.get(3, 3).negate(selected_brush_index + 1);
        rule.toggleSelected(@intCast(u8, x + 1 + (y + 1) * tiles_per_row));
        self.rules.append(rule) catch unreachable;
    }
};

pub const Rule = struct {
    name: [25:0]u8 = [_:0]u8{0} ** 25,
    rule_tiles: [25]RuleTile = undefined,
    chance: u8 = 100,
    result_tiles: aya.utils.FixedList(u8, 25), // indices into the tileset image
    group: u8 = 0, // UI-relevant: used to group Rules into a tree leaf node visually

    pub fn init() Rule {
        return .{
            .rule_tiles = [_]RuleTile{RuleTile{ .tile = 0, .state = .none }} ** 25,
            .result_tiles = aya.utils.FixedList(u8, 25).init(),
        };
    }

    pub fn clone(self: Rule) Rule {
        var new_rule = Rule.init();
        std.mem.copy(u8, &new_rule.name, &self.name);
        std.mem.copy(RuleTile, &new_rule.rule_tiles, &self.rule_tiles);
        std.mem.copy(u8, &new_rule.result_tiles.items, &self.result_tiles.items);
        new_rule.result_tiles.len = self.result_tiles.len;
        new_rule.chance = self.chance;
        new_rule.group = self.group;
        return new_rule;
    }

    pub fn clearPatternData(self: *Rule) void {
        self.rule_tiles = [_]RuleTile{RuleTile{ .tile = 0, .state = .none }} ** 25;
    }

    pub fn get(self: *Rule, x: usize, y: usize) *RuleTile {
        return &self.rule_tiles[x + y * 5];
    }

    pub fn resultTile(self: *Rule, random: usize) usize {
        const index = std.rand.limitRangeBiased(usize, random, self.result_tiles.len);
        return self.result_tiles.items[index];
    }

    pub fn toggleSelected(self: *Rule, index: u8) void {
        if (self.result_tiles.indexOf(index)) |slice_index| {
            _ = self.result_tiles.swapRemove(slice_index);
        } else {
            self.result_tiles.append(index);
        }
    }

    pub fn flip(self: *Rule, dir: enum { horizontal, vertical }) void {
        if (dir == .vertical) {
            for ([_]usize{ 0, 1 }) |y| {
                for ([_]usize{ 0, 1, 2, 3, 4 }) |x| {
                    std.mem.swap(RuleTile, &self.rule_tiles[x + y * 5], &self.rule_tiles[x + (4 - y) * 5]);
                }
            }
        } else {
            for ([_]usize{ 0, 1 }) |x| {
                for ([_]usize{ 0, 1, 2, 3, 4 }) |y| {
                    std.mem.swap(RuleTile, &self.rule_tiles[x + y * 5], &self.rule_tiles[(4 - x) + y * 5]);
                }
            }
        }
    }

    pub fn shift(self: *Rule, dir: enum { left, right, up, down }) void {
        var x_incr: i32 = if (dir == .left) -1 else 1;
        var x_vals = [_]usize{ 0, 1, 2, 3, 4 };
        if (dir == .right) std.mem.reverse(usize, &x_vals);

        var y_incr: i32 = if (dir == .up) -1 else 1;
        var y_vals = [_]usize{ 0, 1, 2, 3, 4 };
        if (dir == .down) std.mem.reverse(usize, &y_vals);

        if (dir == .left or dir == .right) {
            for (y_vals) |y| {
                for (x_vals) |x| {
                    self.swap(x, y, @intCast(i32, x) + x_incr, @intCast(i32, y));
                }
            }
        } else {
            for (x_vals) |x| {
                for (y_vals) |y| {
                    self.swap(x, y, @intCast(i32, x), @intCast(i32, y) + y_incr);
                }
            }
        }
    }

    fn swap(self: *Rule, x: usize, y: usize, new_x: i32, new_y: i32) void {
        // destinations can be invalid and when they are we just reset the source values
        if (new_x >= 0 and new_x < 5 and new_y >= 0 and new_y < 5) {
            self.rule_tiles[@intCast(usize, new_x + new_y * 5)] = self.rule_tiles[x + y * 5].clone();
        }
        self.rule_tiles[x + y * 5].reset();
    }
};

pub const RuleTile = struct {
    tile: usize = 0,
    state: RuleState = .none,

    pub const RuleState = enum(u4) {
        none,
        negated,
        required,

        pub fn jsonStringify(self: RuleState, _: std.json.StringifyOptions, writer: anytype) !void {
            try writer.print("{d}", .{@enumToInt(self)});
        }
    };

    pub fn clone(self: RuleTile) RuleTile {
        return .{ .tile = self.tile, .state = self.state };
    }

    pub fn reset(self: *RuleTile) void {
        self.tile = 0;
        self.state = .none;
    }

    pub fn passes(self: RuleTile, tile: usize) bool {
        if (self.state == .none) return false;
        if (tile == self.tile) {
            return self.state == .required;
        }
        return self.state == .negated;
    }

    pub fn toggleState(self: *RuleTile, new_state: RuleState) void {
        if (self.tile == 0) {
            self.state = new_state;
        } else {
            self.tile = 0;
            self.state = .none;
        }
    }

    pub fn negate(self: *RuleTile, index: usize) void {
        if (self.tile == 0) {
            self.tile = index;
            self.state = .negated;
        } else {
            self.tile = 0;
            self.state = .none;
        }
    }

    pub fn require(self: *RuleTile, index: usize) void {
        if (self.tile == 0) {
            self.tile = index;
            self.state = .required;
        } else {
            self.tile = 0;
            self.state = .none;
        }
    }
};
