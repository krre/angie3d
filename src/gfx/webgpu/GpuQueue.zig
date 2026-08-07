const GpuCommandBuffer = @import("GpuCommandBuffer.zig");
const js = @import("../../js.zig");
const Id = @import("../../types.zig").Id;

const GpuQueue = @This();

id: Id,

pub fn init(id: Id) GpuQueue {
    return GpuQueue{
        .id = id,
    };
}

pub fn deinit(self: GpuQueue) void {
    js.remove(self.id);
}

pub fn addCommandBuffer(self: GpuQueue, buffer: GpuCommandBuffer) void {
    js.queueAddCommandBuffer(self.id, buffer.id);
}

pub fn submit(self: GpuQueue) void {
    js.queueSubmit(self.id);
}
