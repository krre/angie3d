const std = @import("std");
const Application = @import("../core/Application.zig");
const Pos3D = @import("geometry.zig").Pos3D;
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

pub fn update(self: *Multiverse) void {
    if (self.view) |*v| {
        v.update();
    }
}
