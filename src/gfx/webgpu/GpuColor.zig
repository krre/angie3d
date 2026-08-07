const Color = @import("../../ui/Color.zig");
const js = @import("../../js.zig");
const Id = @import("../../types.zig").Id;

const GpuColor = @This();

id: Id,

pub fn init(color: Color) GpuColor {
    return GpuColor{
        .id = js.color(color.r, color.g, color.b, color.a),
    };
}

pub fn deinit(self: GpuColor) void {
    js.remove(self.id);
}
