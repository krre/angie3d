const webgpu = @import("webgpu.zig");
const GpuColor = webgpu.GpuColor;
const GpuLoadOp = webgpu.GpuLoadOp;
const GpuStoreOp = webgpu.GpuStoreOp;
const GpuTextureView = @import("GpuTextureView.zig");
const js = @import("../../js.zig");
const Id = @import("../../types.zig").Id;

const GpuRenderPassColorAttachment = @This();

id: Id,
view: GpuTextureView,
load_op: GpuLoadOp,
store_op: GpuStoreOp,
clear_value: ?GpuColor,

pub fn init(view: GpuTextureView, load_op: GpuLoadOp, store_op: GpuStoreOp, clear_value: ?GpuColor) GpuRenderPassColorAttachment {
    var color_id: Id = 0;

    if (clear_value) |value| {
        color_id = value.id;
    }

    return GpuRenderPassColorAttachment{
        .id = js.renderPassColorAttachment(view.id, @intFromEnum(load_op), @intFromEnum(store_op), color_id),
        .view = view,
        .load_op = load_op,
        .store_op = store_op,
        .clear_value = clear_value,
    };
}

pub fn deinit(self: GpuRenderPassColorAttachment) void {
    js.remove(self.id);

    if (self.clear_value != null) {
        self.clear_value.?.deinit();
    }
}
