const std = @import("std");
const aya = @import("aya");
const editor = @import("../editor.zig");
usingnamespace @import("imgui");

pub fn draw(state: *editor.AppState) void {
    if (igBegin("Layers", null, ImGuiWindowFlags_None)) {}
    igEnd();
}
