const GpuTexture = @import("GpuTexture.zig");
const js = @import("../../js.zig");
const Id = @import("../../types.zig").Id;

const GpuCanvasContext = @This();

id: Id,

pub fn init() GpuCanvasContext {
    return GpuCanvasContext{
        .id = js.canvasContext(),
    };
}

pub fn getCurrentTexture(self: GpuCanvasContext) GpuTexture {
    return GpuTexture.init(js.canvasContextGetCurrentTexture(self.id));
}
