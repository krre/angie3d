const std = @import("std");
const Allocator = std.mem.Allocator;
const angie3d = @import("angie3d");
const console = angie3d.console;
const js = angie3d.js;
const Box = angie3d.ui.widget.Box;
const Application = angie3d.core.Application;

const HelloWorld = struct {
    pub var app: Application = undefined;
    var root: Box = undefined;

    pub fn init(allocator: Allocator) void {
        root = Box.init(allocator);
        app = Application.init(allocator, &root.widget);
        Application.setTitle("Hello World!");
    }
};

export fn start() void {
    HelloWorld.init(std.heap.wasm_allocator);
    js.event_handler = HelloWorld.app.eventHandler();
    HelloWorld.app.render();
}
