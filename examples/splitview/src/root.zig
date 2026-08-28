const angie3d = @import("angie3d");
const Widget = angie3d.ui.widget.Widget;
const Rectangle = angie3d.ui.widget.Rectangle;
const Application = angie3d.core.Application;
const View = angie3d.ui.View;
const SplitView = angie3d.ui.SplitView;
const Node = angie3d.ui.node.Node;

const SplitViewExample = struct {
    scene: Node,

    pub fn init(app: *Application) !SplitViewExample {
        app.setTitle("SplitView Example");
        var splitViewExample = SplitViewExample{ .scene = Node.init() };

        const view_left = View.init(&splitViewExample.scene);
        const view_right = View.init(&splitViewExample.scene);

        var split_view = SplitView.init(.horizontal);
        try split_view.addView(app.allocator, .{ .view = view_left });
        try split_view.addView(app.allocator, .{ .view = view_right });

        app.setView(.{ .split_view = split_view });

        return splitViewExample;
    }
};

export fn start() void {
    angie3d.runApp(SplitViewExample);
}
