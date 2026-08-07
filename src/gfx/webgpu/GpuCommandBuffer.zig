const js = @import("../../js.zig");
const Id = @import("../../types.zig").Id;

const GpuCommandBuffer = @This();

id: Id,

pub fn init(id: Id) GpuCommandBuffer {
    return GpuCommandBuffer{
        .id = id,
    };
}

pub fn deinit(self: GpuCommandBuffer) void {
    js.remove(self.id);
}
