const Node = @import("../node/node.zig").Node;
const geometry = @import("../geometry.zig");
const Transform = geometry.Transform;
const Pos3D = geometry.Pos3D;

pub const Spatial = struct {
    node: Node,
    transform: Transform = .{},
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
