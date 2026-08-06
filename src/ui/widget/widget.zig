pub const Box = @import("Box.zig");
pub const Border = @import("Border.zig");

const std = @import("std");
const geometry = @import("../geometry.zig");
const Pos3D = geometry.Pos3D;
const Size3D = geometry.Size3D;
const Node = @import("../node/node.zig").Node;

pub const Widget = struct {
    node: Node,
    pos: Pos3D = .{ .x = 0, .y = 0, .z = 0 },
    size: Size3D = .{ .width = 0, .height = 0, .depth = 0 },
    vtable: *const VTable,
    allocator: std.mem.Allocator,

    pub const VTable = struct {
        draw: *const fn (self: *Widget) void,
    };

    pub fn init(allocator: std.mem.Allocator, vtable: *const VTable) Widget {
        return Widget{
            .node = Node.init(),
            .vtable = vtable,
            .allocator = allocator,
        };
    }

    pub fn move(self: *Widget, pos: Pos3D) void {
        self.pos = pos;
    }

    pub fn resize(self: *Widget, size: Size3D) void {
        self.size = size;
    }

    pub fn draw(self: *Widget) void {
        self.vtable.draw(self);
    }
};
