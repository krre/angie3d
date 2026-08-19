const std = @import("std");
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;
const Universe = @import("Universe.zig");
const Size2D = @import("geometry.zig").Size2D;

pub const View = struct {
    universe: *Universe,

    pub fn init(universe: *Universe) View {
        return View{
            .universe = universe,
        };
    }

    pub fn resize(self: *View, size: Size2D) void {
        _ = self;
        _ = size;
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

    pub fn init(orientation: Orientation) SplitView {
        return SplitView{
            .orientation = orientation,
            .views = ArrayList(AnyView).empty,
        };
    }

    pub fn addView(self: *SplitView, allocator: Allocator, view: AnyView) !void {
        try self.views.append(allocator, view);
    }

    pub fn resize(self: *SplitView, size: Size2D) void {
        for (self.views.items) |*view| {
            view.resize(size);
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
