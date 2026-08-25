const Node = @import("../node/node.zig").Node;
const Pos3D = @import("../geometry.zig").Pos3D;

pub const Spatial = struct {
    node: Node,
    pos: Pos3D = .{ .x = 0, .y = 0, .z = 0 },
};

pub fn init() Spatial {
    return Spatial{
        .node = Node.init(),
    };
}

pub fn fromNode(node: *Node) *Spatial {
    return @fieldParentPtr("node", node);
}

pub fn move(self: *Spatial, pos: Pos3D) void {
    self.pos = pos;
}
