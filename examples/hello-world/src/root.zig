const angie3d = @import("angie3d");
const Widget = angie3d.ui.widget.Widget;
const Rectangle = angie3d.ui.widget.Rectangle;
const Application = angie3d.core.Application;
const View = angie3d.ui.View;
const Universe = angie3d.ui.Universe;

const HelloWorld = struct {
    universe: *Universe,

    pub fn init(app: *Application) HelloWorld {
        app.setTitle("Hello World!");

        const universe = app.allocator.create(Universe) catch |err| {
            switch (err) {
                error.OutOfMemory => @panic("Out of memory to create Universe"),
            }
        };

        const view = View{
            .universe = universe,
        };
        app.multiverse.setView(.{ .view = view });

        return HelloWorld{
            .universe = universe,
        };
    }
};

export fn start() void {
    angie3d.runApp(HelloWorld);
}
