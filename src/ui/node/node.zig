const std = @import("std");

pub const Node = struct {
    parent: ?*Node,
    children: std.ArrayList(*Node),

    pub fn init() Node {
        return Node{ .parent = null, .children = std.ArrayList(*Node).empty };
    }

    pub fn deinit(self: *Node) void {
        for (self.children.items) |child| {
            child.deinit();
        }

        self.children.deinit();
    }

    pub fn addChild(self: *Node, child: *Node) !void {
        child.parent = self;
        try self.children.append(child);
    }
};
