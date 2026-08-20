pub const Pos2D = struct {
    x: i32,
    y: i32,

    pub const zero: Pos2D = .{ .x = 0, .y = 0 };
};

pub const Size2D = struct {
    width: u32,
    height: u32,

    pub const zero: Size2D = .{ .width = 0, .height = 0 };
};

pub const Pos3D = struct {
    x: f32,
    y: f32,
    z: f32,

    pub const zero: Pos3D = .{ .x = 0, .y = 0, .z = 0 };
};

pub const Size3D = struct {
    width: f32,
    height: f32,
    depth: f32,

    pub const zero: Size3D = .{ .width = 0, .height = 0, .depth = 0 };
};
