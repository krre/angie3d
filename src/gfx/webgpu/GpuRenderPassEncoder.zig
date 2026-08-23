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

pub fn setViewport(self: GpuRenderPassEncoder, x: f32, y: f32, width: f32, height: f32, minDepth: f32, maxDepth: f32) void {
    js.renderPassSetViewport(self.id, x, y, width, height, minDepth, maxDepth);
}

pub fn setScissorRect(self: GpuRenderPassEncoder, x: u32, y: u32, width: u32, height: u32) void {
    js.renderPassSetScissorRect(self.id, x, y, width, height);
}

pub fn end(self: GpuRenderPassEncoder) void {
    js.renderPassEnd(self.id);
}
