pub const ResolutionPolicy = enum {
    default,
    no_border,
    no_border_pixel_perfect,
    show_all,
    show_all_pixel_perfect,
    best_fit,
};

pub const ResolutionScaler = struct {
    x: i32 = 0,
    y: i32 = 0,
    w: i32,
    h: i32,
    scale: f32 = 1,
};
