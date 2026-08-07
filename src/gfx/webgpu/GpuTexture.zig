const GpuTextureView = @import("GpuTextureView.zig");
const js = @import("../../js.zig");
const Id = @import("../../types.zig").Id;

const GpuTexture = @This();

id: Id,

pub fn init(id: Id) GpuTexture {
    return GpuTexture{
        .id = id,
    };
}

pub fn deinit(self: GpuTexture) void {
    js.destroy(self.id);
}

pub fn createView(self: GpuTexture) GpuTextureView {
    return GpuTextureView.init(js.textureCreateView(self.id));
}
