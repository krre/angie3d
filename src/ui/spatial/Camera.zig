const Spatial = @import("spatial.zig").Spatial;

const Camera = @This();

spatial: Spatial,

pub fn init() Camera {
    return Camera{ .spatial = Spatial.init() };
}

pub fn fromSpatial(spatial: *Spatial) *Camera {
    return @fieldParentPtr("spatial", spatial);
}
