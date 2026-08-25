const angie3d = @import("angie3d");
const Widget = angie3d.ui.widget.Widget;
const Rectangle = angie3d.ui.widget.Rectangle;
const Application = angie3d.core.Application;
const View = angie3d.ui.View;
const Node = angie3d.ui.node.Node;

const HelloWorldExample = struct {
    scene: Node,

    pub fn init(app: *Application) !HelloWorldExample {
        app.setTitle("Hello World Example");
        var helloWorldExample = HelloWorldExample{ .scene = Node.init() };

        app.setView(.{
            .view = View.init(&helloWorldExample.scene),
        });

        return helloWorldExample;
    }
};

export fn start() void {
    angie3d.runApp(HelloWorldExample);
}
