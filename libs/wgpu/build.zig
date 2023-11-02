const std = @import("std");
const Builder = std.build.Builder;
const gpu = @import("mach_gpu");

pub var mach_module: *std.build.Module = undefined;

pub fn linkArtifact(b: *std.build, exe: *std.Build.Step.Compile, target: std.zig.CrossTarget, optimize: std.builtin.Mode) void {
    gpu.link(b, exe, .{}) catch unreachable;

    const mach_gpu_dep = b.dependency("mach_gpu", .{
        .target = target,
        .optimize = optimize,
    });

    mach_module = mach_gpu_dep.module("mach-gpu");

    // exe.addObjectFile(.{ .path = "/Users/mikedesaro/Desktop/libdawn.a" });

    // const b = exe.step.owner;

    // switch (target.os.tag) {
    //     .windows => {
    //         const dawn_dep = b.dependency("dawn_x86_64_windows_gnu", .{});
    //         exe.addLibraryPath(.{ .path = dawn_dep.builder.build_root.path.? });
    //         exe.addLibraryPath(.{ .path = thisDir() ++ "/../system-sdk/windows/lib/x86_64-windows-gnu" });

    //         exe.linkSystemLibraryName("ole32");
    //         exe.linkSystemLibraryName("dxguid");
    //     },
    //     .linux => {
    //         if (target.cpu.arch.isX86()) {
    //             const dawn_dep = b.dependency("dawn_x86_64_linux_gnu", .{});
    //             exe.addLibraryPath(.{ .path = dawn_dep.builder.build_root.path.? });
    //         } else {
    //             const dawn_dep = b.dependency("dawn_aarch64_linux_gnu", .{});
    //             exe.addLibraryPath(.{ .path = dawn_dep.builder.build_root.path.? });
    //         }
    //     },
    //     .macos => {
    //         exe.addFrameworkPath(.{ .path = thisDir() ++ "/../system-sdk/macos12/System/Library/Frameworks" });
    //         exe.addSystemIncludePath(.{ .path = thisDir() ++ "/../system-sdk/macos12/usr/include" });
    //         exe.addLibraryPath(.{ .path = thisDir() ++ "/../system-sdk/macos12/usr/lib" });

    //         if (target.cpu.arch.isX86()) {
    //             const dawn_dep = b.dependency("dawn_x86_64_macos", .{});
    //             exe.addLibraryPath(.{ .path = dawn_dep.builder.build_root.path.? });
    //         } else {
    //             const dawn_dep = b.dependency("dawn_aarch64_macos", .{});
    //             exe.addLibraryPath(.{ .path = dawn_dep.builder.build_root.path.? });
    //         }

    //         exe.linkSystemLibraryName("objc");
    //         exe.linkFramework("Metal");
    //         exe.linkFramework("CoreGraphics");
    //         exe.linkFramework("Foundation");
    //         exe.linkFramework("IOKit");
    //         exe.linkFramework("IOSurface");
    //         exe.linkFramework("QuartzCore");
    //     },
    //     else => unreachable,
    // }

    // exe.linkSystemLibraryName("dawn");
    // exe.linkLibC();
    // exe.linkLibCpp();

    // exe.addIncludePath(.{ .path = thisDir() ++ "/libs/dawn/include" });
    // exe.addIncludePath(.{ .path = thisDir() ++ "/src" });

    // exe.addCSourceFile(.{
    //     .file = .{ .path = thisDir() ++ "/src/dawn.cpp" },
    //     .flags = &.{ "-std=c++17", "-fno-sanitize=undefined" },
    // });
    // exe.addCSourceFile(.{
    //     .file = .{ .path = thisDir() ++ "/src/dawn_proc.c" },
    //     .flags = &.{"-fno-sanitize=undefined"},
    // });
}

pub fn getModule(b: *std.Build, zpool: *std.build.Module, sdl: *std.build.Module) *std.build.Module {
    return b.createModule(.{
        .source_file = .{ .path = thisDir() ++ "/src/zgpu.zig" },
        .dependencies = &.{
            .{ .name = "zpool", .module = zpool },
            .{ .name = "sdl", .module = sdl },
            .{ .name = "mach_gpu", .module = mach_module },
        },
    });
}

inline fn thisDir() []const u8 {
    return comptime std.fs.path.dirname(@src().file) orelse ".";
}
