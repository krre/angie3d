const js = @import("../../js.zig");
const Id = @import("../../types.zig").Id;

const GpuAdapter = @This();

id: Id,

pub fn init() GpuAdapter {
    return GpuAdapter{
        .id = js.adapter(),
    };
}
