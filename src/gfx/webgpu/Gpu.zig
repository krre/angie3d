const js = @import("../../js.zig");
const Id = @import("../../types.zig").Id;

const Gpu = @This();

id: Id,

pub fn init() Gpu {
    return Gpu{
        .id = js.gpu(),
    };
}
