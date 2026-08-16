const angie3d = @import("angie3d");
const Widget = angie3d.ui.widget.Widget;
const Rectangle = angie3d.ui.widget.Rectangle;
const Application = angie3d.core.Application;
const View = angie3d.ui.View;

const HelloWorld = struct {
    root: Rectangle,

    pub fn init(app: *Application) HelloWorld {
        app.setTitle("Hello World!");

        const view = View{};
        app.multiverse.setView(.{ .view = view });

        return HelloWorld{
            .root = Rectangle.init(),
        };
    }
};

export fn start() void {
    angie3d.runApp(HelloWorld);
}
