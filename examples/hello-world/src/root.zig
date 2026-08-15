const angie3d = @import("angie3d");
const Widget = angie3d.ui.widget.Widget;
const Rectangle = angie3d.ui.widget.Rectangle;
const Application = angie3d.core.Application;

const HelloWorld = struct {
    root: Rectangle,

    pub fn init(app: *Application) HelloWorld {
        app.setTitle("Hello World!");

        return HelloWorld{
            .root = Rectangle.init(),
        };
    }
};

export fn main() void {
    angie3d.runApp(HelloWorld);
}
