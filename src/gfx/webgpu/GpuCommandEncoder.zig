const GpuRenderPassEncoder = @import("GpuRenderPassEncoder.zig");
const GpuRenderPassDescriptor = @import("GpuRenderPassDescriptor.zig");
const GpuCommandBuffer = @import("GpuCommandBuffer.zig");
const js = @import("../../js.zig");
const Id = @import("../../types.zig").Id;

const GpuCommandEncoder = @This();

id: Id,

pub fn init(id: Id) GpuCommandEncoder {
    return GpuCommandEncoder{
        .id = id,
    };
}

pub fn deinit(self: GpuCommandEncoder) void {
    js.remove(self.id);
}

pub fn beginRenderPass(self: GpuCommandEncoder, descriptor: GpuRenderPassDescriptor) GpuRenderPassEncoder {
    return GpuRenderPassEncoder.init(js.commandEncoderBeginRenderPass(self.id, descriptor.id));
}

pub fn finish(self: GpuCommandEncoder) GpuCommandBuffer {
    return GpuCommandBuffer.init(js.commandEncoderFinish(self.id));
}
