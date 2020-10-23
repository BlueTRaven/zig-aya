const std = @import("std");
const aya = @import("aya");
const math = aya.math;
usingnamespace @import("imgui");

const editor = @import("../editor.zig");
const data = @import("data.zig");

const AppState = data.AppState;
const Tilemap = data.Tilemap;
const Tileset = data.Tileset;
const Brushset = @import("brushset.zig").Brushset;
const Size = data.Size;
const RuleSet = data.RuleSet;
const Rule = data.Rule;
const Camera = @import("../camera.zig").Camera;

var name_buf: [25:0]u8 = undefined;
var rule_label_buf: [25:0]u8 = undefined;

var drag_drop_state = struct {
    source: union(enum) {
        rule: *Rule,
        group: u8,
    } = undefined,
    from: usize = 0,
    to: usize = 0,
    above_group: bool = false,
    completed: bool = false,
    active: bool = false,
    rendering_group: bool = false,
    dropped_in_group: bool = false,

    pub fn isGroup(self: @This()) bool {
        return switch (self.source) {
            .group => true,
            else => false,
        };
    }

    pub fn handle(self: *@This(), rules: *std.ArrayList(Rule)) void {
        self.completed = false;
        switch (self.source) {
            .group => swapGroups(rules),
            else => swapRules(rules),
        }
        self.above_group = false;
    }
}{};

pub const AutoTilemapLayer = struct {
    name: [:0]const u8,
    tilemap: Tilemap,
    brushset: Brushset,
    tileset: Tileset,
    ruleset: RuleSet,
    ruleset_groups: std.AutoHashMap(u8, []const u8),
    map_dirty: bool = false,

    pub fn init(name: []const u8, size: Size, tile_size: usize) AutoTilemapLayer {
        return .{
            .name = aya.mem.allocator.dupeZ(u8, name) catch unreachable,
            .tilemap = Tilemap.init(size),
            .brushset = Brushset.init(tile_size),
            .tileset = Tileset.init(tile_size),
            .ruleset = RuleSet.init(),
            .ruleset_groups = std.AutoHashMap(u8, []const u8).init(aya.mem.allocator), // TODO: maybe [:0]u8?
        };
    }

    pub fn deinit(self: @This()) void {
        aya.mem.allocator.free(self.name);
        self.tilemap.deinit();
        self.brushset.deinit();
        self.tileset.deinit();
        self.ruleset.deinit();
    }

    pub fn getGroupName(self: @This(), group: u8) []const u8 {
        return self.ruleset_groups.get(group) orelse "Unnamed Group";
    }

    pub fn renameGroup(self: *@This(), group: u8, name: []const u8) void {
        if (self.ruleset_groups.remove(group)) |entry| {
            aya.mem.allocator.free(entry.value);
        }
        self.ruleset_groups.put(group, aya.mem.allocator.dupe(u8, name) catch unreachable) catch unreachable;
    }

    pub fn removeGroupIfEmpty(self: *@This(), group: u8) void {
        for (self.ruleset.rules.items) |rule| {
            if (rule.group == group) return;
        }
        if (self.ruleset_groups.remove(group)) |entry| {
            aya.mem.allocator.free(entry.value);
        }
    }

    pub fn draw(self: *@This(), state: *AppState, is_selected: bool) void {
        if (!is_selected) return;

        if (is_selected) {
            self.brushset.draw();
        }

        igPushStyleVarVec2(ImGuiStyleVar_WindowMinSize, .{ .x = 365 });
        defer igPopStyleVar(1);

        defer igEnd();
        if (!igBegin("Rules", null, ImGuiWindowFlags_None)) return;

        var group: u8 = 0;
        var delete_index: usize = std.math.maxInt(usize);
        var i: usize = 0;
        while (i < self.ruleset.rules.items.len) : (i += 1) {
            // if we have a Rule in a group render all the Rules in that group at once
            if (self.ruleset.rules.items[i].group > 0 and self.ruleset.rules.items[i].group != group) {
                group = self.ruleset.rules.items[i].group;
            }

            if (self.drawRule(&self.ruleset, &self.ruleset.rules.items[i], i)) {
                delete_index = i;
            }
        }

        if (delete_index < self.ruleset.rules.items.len) {
            const removed = self.ruleset.rules.orderedRemove(delete_index);
            if (removed.group > 0) {
                self.removeGroupIfEmpty(removed.group);
            }
            self.map_dirty = true;
        }

        // handle drag and drop swapping
        if (drag_drop_state.completed) {
            drag_drop_state.handle(&self.ruleset.rules);
        }

        if (ogButton("Add Rule")) {
            self.ruleset.addRule();
        }
        igSameLine(0, 10);
    }

    pub fn drawRule(self: *@This(), ruleset: *RuleSet, rule: *Rule, index: usize) bool {
        igPushIDPtr(rule);
        defer igPopID();

        rulesDragDrop(index, rule, false);

        // right-click the move button to add the Rule to a group only if not already in a group
        if (rule.group == 0) {
            if (igIsItemHovered(ImGuiHoveredFlags_None) and igIsMouseClicked(ImGuiMouseButton_Right, false)) {
                igOpenPopup("##group-name");
                std.mem.set(u8, &name_buf, 0);
            }

            igSetNextWindowPos(igGetIO().MousePos, ImGuiCond_Appearing, .{ .x = 0.5 });
            if (igBeginPopup("##group-name", ImGuiWindowFlags_None)) {
                defer igEndPopup();

                _ = ogInputText("##group-name", &name_buf, name_buf.len);

                const label_sentinel_index = std.mem.indexOfScalar(u8, &name_buf, 0).?;
                const disabled = label_sentinel_index == 0;
                if (disabled) {
                    igPushItemFlag(ImGuiItemFlags_Disabled, true);
                    igPushStyleVarFloat(ImGuiStyleVar_Alpha, 0.5);
                }

                if (igButton("Add to New Group", .{ .x = -1, .y = 0 })) {
                    igCloseCurrentPopup();

                    // get the next available group
                    rule.group = ruleset.getNextAvailableGroup(self, name_buf[0..label_sentinel_index]);
                    std.mem.set(u8, &name_buf, 0);
                }

                if (disabled) {
                    igPopItemFlag();
                    igPopStyleVar(1);
                }
            }
        }

        igPushItemWidth(115);
        std.mem.copy(u8, &rule_label_buf, &rule.name);
        if (ogInputText("##name", &rule_label_buf, rule_label_buf.len)) {
            std.mem.copy(u8, &rule.name, &rule_label_buf);
        }
        igPopItemWidth();
        igSameLine(0, 4);

        if (ogButton("Pattern")) {
            igOpenPopup("##pattern_popup");
        }
        igSameLine(0, 4);

        if (ogButton("Result")) {
            igOpenPopup("result_popup");
        }
        igSameLine(0, 4);

        igPushItemWidth(50);
        _ = ogDrag(u8, "", &rule.chance, 1, 0, 100);
        igSameLine(0, 4);

        if (ogButton(icons.copy)) {
            ruleset.rules.append(rule.clone()) catch unreachable;
        }
        igSameLine(0, 4);

        if (ogButton(icons.trash)) {
            return true;
        }

        // if this is the last item, add an extra drop zone for reordering
        if (index == ruleset.rules.items.len - 1) {
            rulesDragDrop(index + 1, rule, true);
        }

        // display the popup a bit to the left to center it under the mouse
        igSetNextWindowPos(igGetIO().MousePos, ImGuiCond_Appearing, .{ .x = 0.5 });
        if (igBeginPopup("##pattern_popup", ImGuiWindowFlags_None)) {
            self.patternPopup(rule);

            var size = ogGetContentRegionAvail();
            if (igButton("Clear", ImVec2{ .x = (size.x - 4) / 1.7 })) {
                rule.clearPatternData();
            }
            igSameLine(0, 4);

            if (igButton("...", .{ .x = -1, .y = 0 })) {
                igOpenPopup("rules_hamburger");
            }

            self.rulesHamburgerPopup(rule);

            // quick brush selector
            if (ogKeyPressed(aya.sokol.SAPP_KEYCODE_B)) {
                if (igIsPopupOpenID(igGetIDStr("##brushes"))) {
                    igClosePopupToLevel(1, true);
                } else {
                    igOpenPopup("##brushes");
                }
            }

            // nested popup
            igSetNextWindowPos(igGetIO().MousePos, ImGuiCond_Appearing, .{ .x = 0.5 });
            if (igBeginPopup("##brushes", ImGuiWindowFlags_NoTitleBar)) {
                self.brushset.drawWithoutWindow();
                igEndPopup();
            }

            igEndPopup();
        }

        igSetNextWindowPos(igGetIO().MousePos, ImGuiCond_Appearing, .{ .x = 0.5 });
        if (igBeginPopup("result_popup", ImGuiWindowFlags_NoResize | ImGuiWindowFlags_AlwaysAutoResize)) {
            self.resultPopup(rule);
            igEndPopup();
        }

        return false;
    }

    fn patternPopup(self: *@This(), rule: *Rule) void {
        igText("Pattern");
        igSameLine(0, igGetWindowContentRegionWidth() - 65);
        igText(icons.question_circle);
        ogUnformattedTooltip(100, "Left Click: select tile and require\nShift + Left Click: select tile and negate\nRight Click: set as empty required\nShift + Right Click: set as empty negated");

        const draw_list = igGetWindowDrawList();

        const rect_size: f32 = 24;
        const pad: f32 = 4;
        const canvas_size = 5 * rect_size + 4 * pad;
        const thickness: f32 = 2;

        var pos = ImVec2{};
        igGetCursorScreenPos(&pos);
        _ = igInvisibleButton("##pattern_button", ImVec2{ .x = canvas_size, .y = canvas_size });
        const mouse_pos = igGetIO().MousePos;
        const hovered = igIsItemHovered(ImGuiHoveredFlags_None);

        var y: usize = 0;
        while (y < 5) : (y += 1) {
            var x: usize = 0;
            while (x < 5) : (x += 1) {
                const pad_x = @intToFloat(f32, x) * pad;
                const pad_y = @intToFloat(f32, y) * pad;
                const offset_x = @intToFloat(f32, x) * rect_size;
                const offset_y = @intToFloat(f32, y) * rect_size;
                var tl = ImVec2{ .x = pos.x + pad_x + offset_x, .y = pos.y + pad_y + offset_y };

                var rule_tile = rule.get(x, y);
                if (rule_tile.tile > 0) {
                    ogAddQuadFilled(draw_list, tl, rect_size, editor.colors.brushes[rule_tile.tile - 1]);
                } else {
                    // if empty rule or just with a modifier
                    ogAddQuadFilled(draw_list, tl, rect_size, editor.colors.rgbToU32(0, 0, 0));
                }

                if (x == 2 and y == 2) {
                    const size = rect_size - thickness;
                    var tl2 = tl;
                    tl2.x += 1;
                    tl2.y += 1;
                    ogAddQuad(draw_list, tl2, size, editor.colors.pattern_center, thickness);
                }

                tl.x -= 1;
                tl.y -= 1;
                if (rule_tile.state == .negated) {
                    const size = rect_size + thickness;
                    ogAddQuad(draw_list, tl, size, editor.colors.brush_negated, thickness);
                } else if (rule_tile.state == .required) {
                    const size = rect_size + thickness;
                    ogAddQuad(draw_list, tl, size, editor.colors.brush_required, thickness);
                }

                if (hovered) {
                    if (tl.x <= mouse_pos.x and mouse_pos.x < tl.x + rect_size and tl.y <= mouse_pos.y and mouse_pos.y < tl.y + rect_size) {
                        if (igIsMouseClicked(ImGuiMouseButton_Left, false)) {
                            self.map_dirty = true;
                            if (igGetIO().KeyShift) {
                                rule_tile.negate(self.brushset.selected.comps.tile_index + 1);
                            } else {
                                rule_tile.require(self.brushset.selected.comps.tile_index + 1);
                            }
                        }

                        if (igIsMouseClicked(ImGuiMouseButton_Right, false)) {
                            self.map_dirty = true;
                            rule_tile.toggleState(if (igGetIO().KeyShift) .negated else .required);
                        }
                    }
                }
            }
        }
    }

    fn rulesHamburgerPopup(self: *@This(), rule: *Rule) void {
        igSetNextWindowPos(igGetIO().MousePos, ImGuiCond_Appearing, .{ .x = 0.5 });
        if (igBeginPopup("rules_hamburger", ImGuiWindowFlags_None)) {
            defer igEndPopup();
            self.map_dirty = true;

            igText("Shift:");
            igSameLine(0, 10);
            if (ogButton(icons.arrow_left)) {
                rule.shift(.left);
            }

            igSameLine(0, 7);
            if (ogButton(icons.arrow_up)) {
                rule.shift(.up);
            }

            igSameLine(0, 7);
            if (ogButton(icons.arrow_down)) {
                rule.shift(.down);
            }

            igSameLine(0, 7);
            if (ogButton(icons.arrow_right)) {
                rule.shift(.right);
            }

            igText("Flip: ");
            igSameLine(0, 10);
            if (ogButton(icons.arrows_alt_h)) {
                rule.flip(.horizontal);
            }

            igSameLine(0, 4);
            if (ogButton(icons.arrows_alt_v)) {
                rule.flip(.vertical);
            }
        }
    }

    /// shows the tileset allowing multiple tiles to be selected
    fn resultPopup(self: *@This(), ruleset: *Rule) void {
        var content_start_pos = ogGetCursorScreenPos();
        const zoom: usize = if (self.tileset.tex.width < 200 and self.tileset.tex.height < 200) 2 else 1;
        const tile_spacing = self.tileset.spacing * zoom;
        const tile_size = self.tileset.tile_size * zoom;

        ogImage(self.tileset.tex.imTextureID(), self.tileset.tex.width * @intCast(i32, zoom), self.tileset.tex.height * @intCast(i32, zoom));

        const draw_list = igGetWindowDrawList();

        // draw selected tiles
        var iter = ruleset.result_tiles.iter();
        while (iter.next()) |index| {
            const per_row = self.tileset.tiles_per_row;
            // TODO: HACK!
            const ts = @import("tileset.zig");
            ts.addTileToDrawList(tile_size, content_start_pos, index, self.tileset.tiles_per_row, tile_spacing);
        }

        // check input for toggling state
        if (igIsItemHovered(ImGuiHoveredFlags_None)) {
            if (igIsMouseClicked(0, false)) {
                var tile = tileIndexUnderMouse(@intCast(usize, tile_size + tile_spacing), content_start_pos);
                const per_row = self.tileset.tiles_per_row;
                ruleset.toggleSelected(@intCast(u8, tile.x + tile.y * per_row));
                self.map_dirty = true;
            }
        }

        if (igButton("Clear", ImVec2{ .x = -1 })) {
            ruleset.result_tiles.clear();
            self.map_dirty = true;
        }
    }

    pub fn handleSceneInput(self: @This(), state: *AppState, camera: Camera, mouse_world: ImVec2) void {
        aya.draw.text(self.name, 100, 0, null);
    }
};

/// handles drag/drop sources and targets
fn rulesDragDrop(index: usize, rule: *Rule, drop_only: bool) void {
    var cursor = ogGetCursorPos();

    if (!drop_only) {
        _ = ogButton(icons.grip_horizontal);
        ogUnformattedTooltip(20, if (rule.group > 0) "Click and drag to reorder" else "Click and drag to reorder\nRight-click to add a group");

        igSameLine(0, 4);
        if (igBeginDragDropSource(ImGuiDragDropFlags_None)) {
            drag_drop_state.active = true;
            _ = igSetDragDropPayload("RULESET_DRAG", null, 0, ImGuiCond_Once);
            drag_drop_state.from = index;
            drag_drop_state.source = .{ .rule = rule };
            _ = igButton(&rule.name, .{ .x = ogGetContentRegionAvail().x, .y = 20 });
            igEndDragDropSource();
        }
    }

    // if we are dragging a group dont allow dragging it into another group
    if (drag_drop_state.active and !(drag_drop_state.isGroup() and rule.group > 0)) {
        const old_pos = ogGetCursorPos();
        cursor.y -= 5;
        igSetCursorPos(cursor);
        igPushStyleColorU32(ImGuiCol_Button, editor.colors.rgbToU32(255, 0, 0));
        _ = igInvisibleButton("", .{ .x = -1, .y = 8 });
        igPopStyleColor(1);
        igSetCursorPos(old_pos);

        if (igBeginDragDropTarget()) {
            if (igAcceptDragDropPayload("RULESET_DRAG", ImGuiDragDropFlags_None)) |payload| {
                drag_drop_state.dropped_in_group = drag_drop_state.rendering_group;
                drag_drop_state.completed = true;
                drag_drop_state.to = index;

                // if this is a group being dragged, we cant rule out the operation since we could have 1 to n items in our group
                if (!drag_drop_state.isGroup()) {
                    // dont allow swapping to the same location, which is the drop target above or below the dragged item
                    if (drag_drop_state.from == drag_drop_state.to or (drag_drop_state.to > 0 and drag_drop_state.from == drag_drop_state.to - 1)) {
                        drag_drop_state.completed = false;
                    }
                }
                drag_drop_state.active = false;
            }
            igEndDragDropTarget();
        }
    }
}

/// handles the actual logic to rearrange the Rule for drag/drop when a Rule is reordered
fn swapRules(rules: *std.ArrayList(Rule)) void {
    // dont assign the group unless we are swapping into a group proper
    if (!drag_drop_state.above_group and drag_drop_state.dropped_in_group) {
        const to = if (rules.items.len == drag_drop_state.to) drag_drop_state.to - 1 else drag_drop_state.to;
        const group = rules.items[to].group;
        rules.items[drag_drop_state.from].group = group;
    } else {
        rules.items[drag_drop_state.from].group = 0;
    }

    // get the total number of steps we need to do the swap. We move to index+1 so account for that when moving to a higher index
    var total_swaps = if (drag_drop_state.from > drag_drop_state.to) drag_drop_state.from - drag_drop_state.to else drag_drop_state.to - drag_drop_state.from - 1;
    while (total_swaps > 0) : (total_swaps -= 1) {
        if (drag_drop_state.from > drag_drop_state.to) {
            std.mem.swap(Rule, &rules.items[drag_drop_state.from], &rules.items[drag_drop_state.from - 1]);
            drag_drop_state.from -= 1;
        } else {
            std.mem.swap(Rule, &rules.items[drag_drop_state.from], &rules.items[drag_drop_state.from + 1]);
            drag_drop_state.from += 1;
        }
    }
}

/// handles the actual logic to rearrange the Rule for drag/drop when a group is reordered
fn swapGroups(rules: *std.ArrayList(Rule)) void {
    var total_in_group = blk: {
        var total: usize = 0;
        for (rules.items) |rule| {
            if (rule.group == drag_drop_state.source.group) total += 1;
        }
        break :blk total;
    };
    var total_swaps = if (drag_drop_state.from > drag_drop_state.to) drag_drop_state.from - drag_drop_state.to else drag_drop_state.to - drag_drop_state.from - total_in_group;
    if (total_swaps == 0) return;

    while (total_swaps > 0) : (total_swaps -= 1) {
        // when moving up, we can just move each item in our group up one slot
        if (drag_drop_state.from > drag_drop_state.to) {
            var j: usize = 0;
            while (j < total_in_group) : (j += 1) {
                std.mem.swap(Rule, &rules.items[drag_drop_state.from + j], &rules.items[drag_drop_state.from - 1 + j]);
            }
            drag_drop_state.from -= 1;
        } else {
            // moving down, we have to move the last item in the group first each step
            var j: usize = total_in_group - 1;
            while (j >= 0) : (j -= 1) {
                std.mem.swap(Rule, &rules.items[drag_drop_state.from + j], &rules.items[drag_drop_state.from + 1 + j]);
                if (j == 0) break;
            }
            drag_drop_state.from += 1;
        }
    }
}

/// helper to find the tile under the mouse given a top-left position of the grid and a grid size
pub fn tileIndexUnderMouse(rect_size: usize, origin: ImVec2) struct { x: usize, y: usize } {
    var pos = igGetIO().MousePos;
    pos.x -= origin.x;
    pos.y -= origin.y;

    return .{ .x = @divTrunc(@floatToInt(usize, pos.x), rect_size), .y = @divTrunc(@floatToInt(usize, pos.y), rect_size) };
}
