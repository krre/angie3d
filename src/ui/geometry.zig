pub const Pos2D = struct {
    x: i32 = 0,
    y: i32 = 0,
};

pub const Size2D = struct {
    width: u32 = 0,
    height: u32 = 0,
};

pub const Pos3D = struct {
    x: f32 = 0,
    y: f32 = 0,
    z: f32 = 0,
};

pub const Vec3D = struct {
    x: f32 = 0,
    y: f32 = 0,
    z: f32 = 0,
};

pub const Size3D = struct {
    width: f32 = 0,
    height: f32 = 0,
    depth: f32 = 0,
};

pub const Quaternion = struct {
    x: f32 = 0,
    y: f32 = 0,
    z: f32 = 0,
    w: f32 = 1,
};

pub const Mat4 = [16]f32;

pub const Transform = struct {
    position: Pos3D = .{},
    rotation: Quaternion = .{},
    scale: Vec3D = .{ .x = 1, .y = 1, .z = 1 },

    local_matrix: Mat4 = identity_matrix,
    world_matrix: Mat4 = identity_matrix,

    pub const identity_matrix: Mat4 = .{
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,
    };
};
