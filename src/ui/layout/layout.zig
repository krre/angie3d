const Node = @import("../node/node.zig").Node;

pub const Layout = struct {
    node: Node,

    pub fn init() Layout {
        return Layout{
            .node = Node.init(),
        };
    }

    pub fn fromNode(node: *Node) *Layout {
        return @fieldParentPtr("node", node);
    }
};
