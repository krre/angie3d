const std = @import("std");
const Widget = @import("widget.zig").Widget;
const Border = @import("Border.zig");
const Color = @import("../Color.zig");

const Box = @This();

widget: Widget,
color: Color = Color.white,
border: Border = .{},

const vtable = Widget.VTable{
    .draw = &draw,
};

pub fn init() Box {
    return Box{ .widget = Widget.init(&vtable) };
}

pub fn asWidget(self: *Box) *Widget {
    return &self.widget;
}

pub fn fromWidget(widget: *Widget) *Box {
    return @fieldParentPtr("widget", widget);
}

fn draw(widget: *Widget) void {
    _ = widget;
}
