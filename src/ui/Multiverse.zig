const std = @import("std");
const Application = @import("../core/Application.zig");
const geometry = @import("geometry.zig");
const Pos3D = geometry.Pos3D;
const Size2D = geometry.Size2D;
const Universe = @import("Universe.zig");
const AnyView = @import("view.zig").AnyView;

const Multiverse = @This();

view: ?AnyView = null,

pub fn init() Multiverse {
    return Multiverse{};
}

pub fn setView(self: *Multiverse, view: AnyView) void {
    self.view = view;
}

pub fn resize(self: *Multiverse, size: Size2D) void {
    if (self.view) |*v| {
        v.resize(size);
    }
}

pub fn render(self: *Multiverse) void {
    if (self.view) |*v| {
        v.render();
    }
}

pub fn update(self: *Multiverse) void {
    if (self.view) |*v| {
        v.update();
    }
}
