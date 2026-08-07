pub const Gpu = @import("Gpu.zig");
pub const GpuAdapter = @import("GpuAdapter.zig");
pub const GpuCanvasContext = @import("GpuCanvasContext.zig");
pub const GpuColor = @import("GpuColor.zig");
pub const GpuCommandBuffer = @import("GpuCommandBuffer.zig");
pub const GpuCommandEncoder = @import("GpuCommandEncoder.zig");
pub const GpuDevice = @import("GpuDevice.zig");
pub const GpuQueue = @import("GpuQueue.zig");
pub const GpuRenderPassColorAttachment = @import("GpuRenderPassColorAttachment.zig");
pub const GpuRenderPassEncoder = @import("GpuRenderPassEncoder.zig");
pub const GpuRenderPassDescriptor = @import("GpuRenderPassDescriptor.zig");
pub const GpuTexture = @import("GpuTexture.zig");
pub const GpuTextureView = @import("GpuTextureView.zig");

pub const GpuLoadOp = enum {
    load,
    clear,
};

pub const GpuStoreOp = enum {
    store,
    discard,
};
