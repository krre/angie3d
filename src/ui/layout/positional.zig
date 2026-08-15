const Layout = @import("layout.zig").Layout;

pub const Position = struct {
    layout: Layout,

    pub fn init() Position {
        return Position{
            .layout = Layout.init(),
        };
    }
};

pub const Center = struct {
    layout: Layout,

    pub fn init() Center {
        return Center{
            .layout = Layout.init(),
        };
    }
};
