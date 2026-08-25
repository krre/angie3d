const std = @import("std");
const Allocator = std.mem.Allocator;

const js = @import("../js.zig");
const geometry = @import("../ui/geometry.zig");
const Widget = @import("../ui/widget/widget.zig").Widget;
const Pos2D = geometry.Pos2D;
const Size2D = geometry.Size2D;
const Renderer = @import("../gfx/Renderer.zig");
const AnyView = @import("../ui/view.zig").AnyView;

const Application = @This();

allocator: Allocator,
renderer: Renderer,
size: Size2D = Size2D.zero,
view: ?AnyView = null,

pub fn init(allocator: Allocator) Application {
    return Application{
        .allocator = allocator,
        .renderer = Renderer.init(),
    };
}

pub fn setTitle(self: *Application, title: []const u8) void {
    _ = self;
    js.setTitle(title.ptr, title.len);
}

pub fn setView(self: *Application, view: AnyView) void {
    self.view = view;
}

pub fn render(self: *Application) void {
    self.renderer.clear();
}

pub fn resize(self: *Application, size: Size2D) void {
    self.size = size;

    if (self.view) |*view| {
        view.resize(size);
    }

    self.render();
}

pub fn mouseMove(self: *Application, pos: Pos2D) void {
    _ = pos;
    self.render();
}

pub fn mouseClick(self: *Application, pos: Pos2D) void {
    _ = pos;
    self.render();
}

pub fn mouseDoubleClick(self: *Application, pos: Pos2D) void {
    _ = pos;
    self.render();
}

pub fn mouseDown(self: *Application, pos: Pos2D, button: u8) void {
    _ = pos;
    _ = button;
    self.render();
}

pub fn mouseUp(self: *Application, pos: Pos2D, button: u8) void {
    _ = pos;
    _ = button;
    self.render();
}

pub fn mouseWheel(self: *Application, pos: Pos2D, delta_y: i8) void {
    _ = pos;
    _ = delta_y;
    self.render();
}

pub fn keyDown(self: *Application, code: u32) void {
    _ = code;
    self.render();
}

pub fn keyUp(self: *Application, code: u32) void {
    _ = code;
    self.render();
}
