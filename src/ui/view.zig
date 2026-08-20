const std = @import("std");
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;
const Universe = @import("Universe.zig");
const Size2D = @import("geometry.zig").Size2D;

pub const View = struct {
    universe: *Universe,
    size: Size2D,

    pub fn init(universe: *Universe) View {
        return View{
            .universe = universe,
            .size = Size2D.zero,
        };
    }

    pub fn resize(self: *View, size: Size2D) void {
        self.size = size;
    }

    pub fn render(self: *View) void {
        _ = self;
    }

    pub fn update(self: *View) void {
        _ = self;
    }
};

pub const SplitView = struct {
    pub const Orientation = enum {
        Horizontal,
        Vertical,
        Layer,
    };

    orientation: Orientation,
    views: ArrayList(AnyView),
    size: Size2D,

    pub fn init(orientation: Orientation) SplitView {
        return SplitView{
            .orientation = orientation,
            .views = ArrayList(AnyView).empty,
            .size = Size2D.zero,
        };
    }

    pub fn addView(self: *SplitView, allocator: Allocator, view: AnyView) !void {
        try self.views.append(allocator, view);
    }

    pub fn resize(self: *SplitView, size: Size2D) void {
        self.size = size;

        for (self.views.items) |*view| {
            var view_size = size;

            if (self.orientation == Orientation.Horizontal) {
                view_size.width = size.width / self.views.items.len;
            } else if (self.orientation == Orientation.Vertical) {
                view_size.height = size.height / self.views.items.len;
            }

            view.resize(view_size);
        }
    }

    pub fn render(self: *SplitView) void {
        for (self.views.items) |*view| {
            view.render();
        }
    }

    pub fn update(self: *SplitView) void {
        for (self.views) |*view| {
            view.update();
        }
    }
};

pub const AnyView = union(enum) {
    view: View,
    split_view: SplitView,

    pub fn resize(self: *AnyView, size: Size2D) void {
        switch (self.*) {
            inline else => |*v| v.resize(size),
        }
    }

    pub fn render(self: *AnyView) void {
        switch (self.*) {
            inline else => |*v| v.render(),
        }
    }

    pub fn update(self: *AnyView) void {
        switch (self.*) {
            inline else => |*v| v.update(),
        }
    }
};
