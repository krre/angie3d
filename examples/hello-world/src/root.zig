const std = @import("std");
const angie3d = @import("angie3d");
const Widget = angie3d.ui.widget.Widget;
const Box = angie3d.ui.widget.Box;
const Application = angie3d.core.Application;

const HelloWorld = struct {
    root: Box,

    pub fn init(app: *Application) HelloWorld {
        app.setTitle("Hello World!");

        return HelloWorld{
            .root = Box.init(app.allocator),
        };
    }

    pub fn rootWidget(self: *HelloWorld) *Widget {
        return &self.root.widget;
    }
};

export fn main() void {
    angie3d.runApp(HelloWorld, std.heap.wasm_allocator);
}
