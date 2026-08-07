const js = @import("../../js.zig");
const Id = @import("../../types.zig").Id;

const GpuRenderPassEncoder = @This();

id: Id,

pub fn init(id: Id) GpuRenderPassEncoder {
    return GpuRenderPassEncoder{
        .id = id,
    };
}

pub fn deinit(self: GpuRenderPassEncoder) void {
    js.remove(self.id);
}

pub fn end(self: GpuRenderPassEncoder) void {
    js.renderPassEnd(self.id);
}
