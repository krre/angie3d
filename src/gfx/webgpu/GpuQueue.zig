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

pub fn submit(self: GpuQueue, command_buffers: []const GpuCommandBuffer) void {
    var ids: [64]Id = undefined;

    for (command_buffers, 0..) |cb, i| {
        ids[i] = cb.id;
    }

    js.queueSubmit(self.id, @ptrCast(&ids), command_buffers.len);
}
