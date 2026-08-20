const angie3d = @import("angie3d");
const Widget = angie3d.ui.widget.Widget;
const Rectangle = angie3d.ui.widget.Rectangle;
const Application = angie3d.core.Application;
const View = angie3d.ui.View;
const SplitView = angie3d.ui.SplitView;
const Universe = angie3d.ui.Universe;

const SplitViewExample = struct {
    universe: *Universe,

    pub fn init(app: *Application) !SplitViewExample {
        app.setTitle("SplitView Example");
        const universe = try app.allocator.create(Universe);

        const view_left = View.init(universe);
        const view_right = View.init(universe);

        var split_view = SplitView.init(SplitView.Orientation.Horizontal);
        try split_view.addView(app.allocator, .{ .view = view_left });
        try split_view.addView(app.allocator, .{ .view = view_right });

        app.multiverse.setView(.{ .split_view = split_view });

        return SplitViewExample{
            .universe = universe,
        };
    }
};

export fn start() void {
    angie3d.runApp(SplitViewExample);
}
