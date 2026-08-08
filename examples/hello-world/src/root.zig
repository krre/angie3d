const std = @import("std");
const angie3d = @import("angie3d");
const core = angie3d.core;
const Widget = angie3d.ui.widget.Widget;
const Box = angie3d.ui.widget.Box;
const Application = angie3d.core.Application;

const HelloWorld = struct {
    const Self = @This();

    root: Box,

    pub fn init(app: *Application) Self {
        app.setTitle("Hello World!");

        return Self{
            .root = Box.init(app.allocator),
        };
    }

    pub fn rootWidget(self: *Self) *Widget {
        return &self.root.widget;
    }
};

export fn main() void {
    core.runApp(HelloWorld, std.heap.wasm_allocator);
}
