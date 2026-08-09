const std = @import("std");
const Allocator = std.mem.Allocator;

const js = @import("../js.zig");
const geometry = @import("../ui/geometry.zig");
const Widget = @import("../ui/widget/widget.zig").Widget;
const Pos2D = geometry.Pos2D;
const Size2D = geometry.Size2D;
const EventHandler = @import("EventHandler.zig");
const Renderer = @import("../gfx/Renderer.zig");

const Application = @This();

allocator: Allocator,
renderer: Renderer,
root_widget: ?*Widget = null,
size: Size2D = .{ .width = 0, .height = 0 },
event_handler: EventHandler = undefined,

pub fn init(allocator: Allocator) Application {
    var application = Application{
        .allocator = allocator,
        .renderer = Renderer.init(),
    };

    application.event_handler = EventHandler{
        .ptr = undefined,
        .vtable = &.{
            .resize = resize,
            .mouseMove = mouseMove,
            .mouseClick = mouseClick,
            .mouseDoubleClick = mouseDoubleClick,
            .mouseDown = mouseDown,
            .mouseUp = mouseUp,
            .mouseWheel = mouseWheel,
            .keyDown = keyDown,
            .keyUp = keyUp,
        },
    };

    return application;
}

pub fn eventHandler(self: *Application) *EventHandler {
    self.event_handler.ptr = self;
    return &self.event_handler;
}

pub fn setTitle(self: *Application, title: []const u8) void {
    _ = self;
    js.setTitle(title.ptr, title.len);
}

pub fn render(self: *Application) void {
    if (self.root_widget) |value| {
        self.renderer.render(value);
    }
}

pub fn resize(ctx: *anyopaque, size: Size2D) void {
    const app: *Application = @ptrCast(@alignCast(ctx));
    app.size = size;
    app.render();
}

pub fn mouseMove(ctx: *anyopaque, pos: Pos2D) void {
    const app: *Application = @ptrCast(@alignCast(ctx));
    _ = pos;
    app.render();
}

pub fn mouseClick(ctx: *anyopaque, pos: Pos2D) void {
    const app: *Application = @ptrCast(@alignCast(ctx));
    _ = pos;
    app.render();
}

pub fn mouseDoubleClick(ctx: *anyopaque, pos: Pos2D) void {
    const app: *Application = @ptrCast(@alignCast(ctx));
    _ = pos;
    app.render();
}

pub fn mouseDown(ctx: *anyopaque, pos: Pos2D, button: u8) void {
    const app: *Application = @ptrCast(@alignCast(ctx));
    _ = pos;
    _ = button;
    app.render();
}

pub fn mouseUp(ctx: *anyopaque, pos: Pos2D, button: u8) void {
    const app: *Application = @ptrCast(@alignCast(ctx));
    _ = pos;
    _ = button;
    app.render();
}

pub fn mouseWheel(ctx: *anyopaque, pos: Pos2D, delta_y: i8) void {
    const app: *Application = @ptrCast(@alignCast(ctx));
    _ = pos;
    _ = delta_y;
    app.render();
}

pub fn keyDown(ctx: *anyopaque, code: u32) void {
    const app: *Application = @ptrCast(@alignCast(ctx));
    _ = code;
    app.render();
}

pub fn keyUp(ctx: *anyopaque, code: u32) void {
    const app: *Application = @ptrCast(@alignCast(ctx));
    _ = code;
    app.render();
}
