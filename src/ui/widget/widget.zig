pub const Box = @import("Box.zig");
pub const Rectangle = @import("Rectangle.zig");
pub const Border = @import("Border.zig");

const geometry = @import("../geometry.zig");
const Size3D = geometry.Size3D;
const Spatial = @import("../spatial/spatial.zig").Spatial;

pub const Widget = struct {
    spatial: Spatial,
    size: Size3D = .{ .width = 0, .height = 0, .depth = 0 },
    vtable: *const VTable,

    pub const VTable = struct {
        draw: *const fn (self: *Widget) void,
    };

    pub fn init(vtable: *const VTable) Widget {
        return Widget{
            .spatial = Spatial.init(),
            .vtable = vtable,
        };
    }

    pub fn fromSpatial(spatial: *Spatial) *Widget {
        return @fieldParentPtr("spatial", spatial);
    }

    pub fn resize(self: *Widget, size: Size3D) void {
        self.size = size;
    }

    pub fn draw(self: *Widget) void {
        self.vtable.draw(self);
    }
};
