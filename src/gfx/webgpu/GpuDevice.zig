const GpuCommandEncoder = @import("GpuCommandEncoder.zig");
const GpuQueue = @import("GpuQueue.zig");
const js = @import("../../js.zig");
const Id = @import("../../types.zig").Id;

const GpuDevice = @This();

id: Id,

pub fn init() GpuDevice {
    return GpuDevice{
        .id = js.device(),
    };
}

pub fn createCommandEncoder(self: GpuDevice) GpuCommandEncoder {
    return GpuCommandEncoder{
        .id = js.deviceCreateCommandEncoder(self.id),
    };
}

pub fn queue(self: GpuDevice) GpuQueue {
    return GpuQueue.init(js.deviceQueue(self.id));
}
