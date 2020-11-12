const std = @import("std");
const aya = @import("aya");

pub fn main() !void {
    try aya.run(.{
        .init = init,
        .update = update,
        .render = render,
    });
}

fn init() !void {}

fn update() !void {}

fn render() !void {
    aya.gfx.beginPass(.{});
    aya.gfx.endPass();
}
