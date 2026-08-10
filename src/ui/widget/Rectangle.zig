const std = @import("std");
const Widget = @import("widget.zig").Widget;
const Border = @import("Border.zig");
const Color = @import("../Color.zig");

const Rectangle = @This();

color: Color = Color.white,
border: Border = .{},
widget: Widget,

const vtable = Widget.VTable{
    .draw = &draw,
};

pub fn init(allocator: std.mem.Allocator) Rectangle {
    return Rectangle{ .widget = Widget.init(allocator, &vtable) };
}

fn draw(widget: *Widget) void {
    _ = widget;
}
