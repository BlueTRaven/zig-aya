const std = @import("std");
const ma = @import("zaudio");
const aya = @import("../aya.zig");
const ig = aya.ig;

pub const SoundGroup = struct {
    src: *ma.SoundGroup,

    pub fn deinit(self: SoundGroup) void {
        self.src.destroy();
    }

    pub fn inspect(self: *SoundGroup) void {
        igInspect(self);
    }

    pub fn start(self: *SoundGroup) void {
        self.src.start() catch unreachable;
    }

    pub fn stop(self: *SoundGroup) void {
        self.src.stop() catch unreachable;
    }

    pub fn isPlaying(self: *const SoundGroup) bool {
        return self.isPlaying();
    }

    pub fn setVolume(self: *const SoundGroup, volume: f32) void {
        self.src.setVolume(volume);
    }

    pub fn getVolume(self: *const SoundGroup) f32 {
        return self.src.getVolume();
    }

    pub fn setPan(self: *const SoundGroup, pan: f32) void {
        self.src.setPan(pan);
    }

    pub fn getPan(self: *const SoundGroup) f32 {
        return self.src.getPan();
    }

    pub fn setPanMode(self: *const SoundGroup, pan_mode: ma.PanMode) void {
        self.src.setPanMode(pan_mode);
    }

    pub fn getPanMode(self: *const SoundGroup) ma.PanMode {
        return self.src.getPanMode();
    }

    pub fn setPitch(self: *const SoundGroup, pitch: f32) void {
        self.src.setPitch(pitch);
    }

    pub fn getPitch(self: *const SoundGroup) f32 {
        return self.src.getPitch();
    }
};

fn igInspect(sound: *SoundGroup) void {
    if (!ig.enabled) return;

    if (ig.igBegin("Sound", null, ig.ImGuiWindowFlags_None)) {
        defer ig.igEnd();

        // ig.igText("Is Playing: %d", if (sound.isPlaying()) @as(f32, 1.0) else @as(f32, 0.0));

        var volume = sound.getVolume();
        if (ig.sliderScalar("Volume", f32, .{ .v = &volume, .min = 0, .max = 2 }))
            sound.setVolume(volume);

        var pan = sound.getPan();
        if (ig.sliderScalar("Pan", f32, .{ .v = &pan, .min = -1, .max = 1 }))
            sound.setPan(pan);
    }
}
