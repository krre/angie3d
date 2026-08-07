const js = @import("../../js.zig");
const Id = @import("../../types.zig").Id;

const GpuTextureView = @This();

id: Id,

pub fn init(id: Id) GpuTextureView {
    return GpuTextureView{
        .id = id,
    };
}

pub fn deinit(self: GpuTextureView) void {
    js.remove(self.id);
}
