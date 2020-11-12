const builtin = @import("builtin");
const std = @import("std");

const LibExeObjStep = std.build.LibExeObjStep;
const Builder = std.build.Builder;
const Target = std.build.Target;
const Pkg = std.build.Pkg;

const aya_build = @import("aya/build.zig");

const sokol_build = @import("aya/deps/sokol/build.zig");
const imgui_build = @import("aya/deps/imgui/build.zig");
const stb_build = @import("aya/deps/stb/build.zig");
const fontstash_build = @import("aya/deps/fontstash/build.zig");

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});

    // ImGui requires `pub const imgui = true;` in the root file and `include_imgui` to be true so it is compiled in
    var include_imgui = false;

    // first item in list will be added as "run" so `zig build run` will always work
    const examples = [_][2][]const u8{
        [_][]const u8{ "editor", "editor/main.zig" },
        [_][]const u8{ "mode7", "examples/mode7.zig" },
        [_][]const u8{ "markov", "examples/markov.zig" },
        [_][]const u8{ "clipper", "examples/clipped_sprite.zig" },
        [_][]const u8{ "primitives", "examples/primitives.zig" },
        [_][]const u8{ "entities", "examples/entities.zig" },
        [_][]const u8{ "shaders", "examples/shaders.zig" },
        [_][]const u8{ "atlas_batch", "examples/atlas_batch.zig" },
        [_][]const u8{ "tilemap", "examples/tilemap.zig" },
        [_][]const u8{ "fonts", "examples/fonts.zig" },
        [_][]const u8{ "batcher", "examples/batcher.zig" },
        [_][]const u8{ "offscreen", "examples/offscreen.zig" },
        [_][]const u8{ "dynamic_mesh", "examples/dynamic_mesh.zig" },
        [_][]const u8{ "mesh", "examples/mesh.zig" },
        [_][]const u8{ "empty", "examples/empty.zig" },
        [_][]const u8{ "imgui", "examples/imgui.zig" },
        // 3D junk
        [_][]const u8{ "spinning_cubes", "examples/spinning_cubes.zig" },
        [_][]const u8{ "cubes", "examples/cubes.zig" },
        [_][]const u8{ "cube", "examples/cube.zig" },
        [_][]const u8{ "instancing", "examples/instancing.zig" },
    };

    for (examples) |example, i| {
        include_imgui = true;
        createExe(b, target, example[0], example[1], include_imgui);

        // first element in the list is added as "run" so "zig build run" works
        if (i == 0) {
            createExe(b, target, "run", example[1], include_imgui);
        }
    }

    addTests(b, target, "");
    addBuildShaders(b, target, "");
}

// creates an exe with all the required dependencies
fn createExe(b: *Builder, target: Target, name: []const u8, source: []const u8, include_imgui: bool) void {
    var exe = b.addExecutable(name, source);
    exe.setBuildMode(b.standardReleaseOptions());
    exe.setOutputDir("zig-cache/bin");

    // aya_build.linkArtifact(b, exe, target, include_imgui, "");
    addAyaToArtifact(b, exe, target, include_imgui, "");

    const run_cmd = exe.run();
    const exe_step = b.step(name, b.fmt("run {}.zig", .{name}));
    exe_step.dependOn(&run_cmd.step);
}

pub fn addAyaToArtifact(b: *Builder, artifact: *std.build.LibExeObjStep, target: std.build.Target, include_imgui: bool, comptime prefix_path: []const u8) void {
    sokol_build.linkArtifact(b, artifact, target, include_imgui);
    stb_build.linkArtifact(b, artifact, target, prefix_path);
    fontstash_build.linkArtifact(b, artifact, target, prefix_path);

    if (include_imgui) {
        imgui_build.linkArtifact(b, artifact, target, prefix_path);
    }

    const sokol = Pkg{
        .name = "sokol",
        .path = "aya/deps/sokol/sokol.zig",
    };
    const imgui_pkg = imgui_build.getImGuiPackage(prefix_path);
    const stb_pkg = stb_build.getPackage(prefix_path);
    const fontstash_pkg = fontstash_build.getPackage(prefix_path);

    const shaders = Pkg{
        .name = "shaders",
        .path = "aya/shaders/shaders.zig",
        .dependencies = &[_]Pkg{sokol},
    };
    const shaders3d = Pkg{
        .name = "shaders3d",
        .path = "aya/shaders/shaders3d.zig",
        .dependencies = &[_]Pkg{sokol},
    };
    const aya = Pkg{
        .name = "aya",
        .path = "aya/aya.zig",
        .dependencies = &[_]Pkg{sokol, imgui_pkg, stb_pkg, fontstash_pkg, shaders},
    };

    // packages exported to userland
    artifact.addPackage(sokol);
    artifact.addPackage(imgui_pkg);
    artifact.addPackage(stb_pkg);
    artifact.addPackage(fontstash_pkg);
    artifact.addPackage(aya);
    artifact.addPackage(shaders);
    artifact.addPackage(shaders3d);

    // shaders
    artifact.addIncludeDir("aya/shaders");
    artifact.addCSourceFile("aya/shaders/basics.c", &[_][]const u8{"-std=c99"});
}

// add tests.zig file runnable via "zig build test"
pub fn addTests(b: *Builder, target: Target, comptime prefix_path: []const u8) void {
    var tst = b.addTest(prefix_path ++ "aya/tests.zig");
    addAyaToArtifact(b, tst, target, false, prefix_path);
    const test_step = b.step("test", "Run tests in tests.zig");
    test_step.dependOn(&tst.step);
}

pub fn addBuildShaders(b: *Builder, target: Target, comptime prefix_path: []const u8) void {
    var exe = b.addExecutable("build-shaders", prefix_path ++ "aya/shaders/build_shaders.zig");
    exe.setOutputDir("zig-cache/bin");

    const run_cmd = exe.run();
    const exe_step = b.step("build-shaders", "build all Sokol shaders");
    exe_step.dependOn(&run_cmd.step);
}