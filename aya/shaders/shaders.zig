usingnamespace @import("sokol");

pub extern fn lines_shader_desc() [*c]const sg_shader_desc;
pub extern fn sepia_shader_desc() [*c]const sg_shader_desc;
pub extern fn sprite_shader_desc() [*c]const sg_shader_desc;

// for generating the cimport.zig file uncomment this
// const std = @import("std");
// pub usingnamespace @cImport({
//     if (std.Target.current.os.tag == .macosx) {
//         @cDefine("SOKOL_METAL", "");
//     } else {
//         @cDefine("SOKOL_GLCORE33", "");
//     }
//     @cInclude("sokol/sokol_gfx.h");
//     @cInclude("basics.h");
// });