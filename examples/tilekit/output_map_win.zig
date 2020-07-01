const std = @import("std");
usingnamespace @import("imgui");
const aya = @import("aya");
const tk = @import("tilekit.zig");

pub fn drawWindow(state: *tk.AppState) void {
    if (state.output_map and igBegin("Output Map", &state.output_map, ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_AlwaysAutoResize)) {
        draw(state);
        igEnd();
    }
}

fn draw(state: *tk.AppState) void {
    var origin = ogGetCursorScreenPos();
    _ = igInvisibleButton("", state.mapSize());

    var y: usize = 0;
    while (y < state.map.h) : (y += 1) {
        var x: usize = 0;
        while (x < state.map.w) : (x += 1) {
            const tile = state.map.transformTileWithRules(x, y);
            if (tile == 0) continue;

            const offset_x = @intToFloat(f32, x) * state.map_rect_size;
            const offset_y = @intToFloat(f32, y) * state.map_rect_size;
            var tl = ImVec2{ .x = origin.x + offset_x, .y = origin.y + offset_y };

            drawTile(state, tl, tile - 1);
        }
    }
}

fn drawTile(state: *tk.AppState, tl: ImVec2, tile: usize) void {
    var br = tl;
    br.x += @intToFloat(f32, state.map.tile_size);
    br.y += @intToFloat(f32, state.map.tile_size);

    // tk.drawBrush(state.map_rect_size, tile, tl);
    const rect = uvsForTile(state, tile);
    const uv0 = ImVec2{.x = rect.x, .y = rect.y};
    const uv1 = ImVec2{.x = rect.x + rect.w, .y = rect.y + rect.h};

    ImDrawList_AddImage(igGetWindowDrawList(), state.texture.tex, tl, br, uv0, uv1, 0xffffffff);
}

fn uvsForTile(state: *tk.AppState, tile: usize) aya.math.Rect {
    const x = @intToFloat(f32, @mod(tile, state.tilesPerRow()));
    const y = @intToFloat(f32, @divTrunc(tile, state.tilesPerRow()));

    const inv_w = 1.0 / @intToFloat(f32, state.texture.width);
    const inv_h = 1.0 / @intToFloat(f32, state.texture.height);

    return .{
        .x = x * @intToFloat(f32, state.map.tile_size + state.map.tile_spacing) * inv_w,
        .y = y * @intToFloat(f32, state.map.tile_size + state.map.tile_spacing) * inv_h,
        .w = @intToFloat(f32, state.map.tile_size) * inv_w,
        .h = @intToFloat(f32, state.map.tile_size) * inv_h,
    };
}
