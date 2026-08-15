const Layout = @import("layout.zig").Layout;

pub const Row = struct {
    layout: Layout,

    pub fn init() Row {
        return Row{
            .layout = Layout.init(),
        };
    }
};

pub const Column = struct {
    layout: Layout,

    pub fn init() Column {
        return Column{
            .layout = Layout.init(),
        };
    }
};

pub const Layer = struct {
    layout: Layout,

    pub fn init() Layer {
        return Layer{
            .layout = Layer.init(),
        };
    }
};
