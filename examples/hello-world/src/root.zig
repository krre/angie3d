const angie3d = @import("angie3d");
const Widget = angie3d.ui.widget.Widget;
const Rectangle = angie3d.ui.widget.Rectangle;
const Application = angie3d.core.Application;
const View = angie3d.ui.View;
const Universe = angie3d.ui.Universe;

const HelloWorldExample = struct {
    universe: *Universe,

    pub fn init(app: *Application) !HelloWorldExample {
        app.setTitle("Hello World Example");
        const universe = try app.allocator.create(Universe);

        app.multiverse.setView(.{
            .view = View{
                .universe = universe,
            },
        });

        return HelloWorldExample{
            .universe = universe,
        };
    }
};

export fn start() void {
    angie3d.runApp(HelloWorldExample);
}
