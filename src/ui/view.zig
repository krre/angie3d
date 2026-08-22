const std = @import("std");
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;
const Universe = @import("Universe.zig");
const geometry = @import("geometry.zig");
const Size2D = geometry.Size2D;
const Pos2D = geometry.Pos2D;

pub const View = struct {
    universe: *Universe,
    size: Size2D,
    pos: Pos2D,

    pub fn init(universe: *Universe) View {
        return View{
            .universe = universe,
            .size = Size2D.zero,
            .pos = Pos2D.zero,
        };
    }

    pub fn resize(self: *View, size: Size2D) void {
        self.size = size;
    }

    pub fn move(self: *View, pos: Pos2D) void {
        self.pos = pos;
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
    pos: Pos2D,

    pub fn init(orientation: Orientation) SplitView {
        return SplitView{
            .orientation = orientation,
            .views = ArrayList(AnyView).empty,
            .size = Size2D.zero,
            .pos = Pos2D.zero,
        };
    }

    pub fn addView(self: *SplitView, allocator: Allocator, view: AnyView) !void {
        try self.views.append(allocator, view);
    }

    pub fn resize(self: *SplitView, size: Size2D) void {
        self.size = size;

        for (self.views.items, 0..) |*view, i| {
            var view_size = size;
            var view_pos = view.getPos();

            if (self.orientation == Orientation.Horizontal) {
                view_size.width = size.width / self.views.items.len;
                view_pos.x = @as(i32, @intCast(view_size.width * i));
            } else if (self.orientation == Orientation.Vertical) {
                view_size.height = size.height / self.views.items.len;
                view_pos.x = @as(i32, @intCast(view_size.height * i));
            }

            view.resize(view_size);
            view.move(view_pos);
        }
    }

    pub fn move(self: *SplitView, pos: Pos2D) void {
        self.pos = pos;
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

    pub fn getPos(self: *AnyView) Pos2D {
        return switch (self.*) {
            inline else => |*v| v.pos,
        };
    }

    pub fn resize(self: *AnyView, size: Size2D) void {
        switch (self.*) {
            inline else => |*v| v.resize(size),
        }
    }

    pub fn move(self: *AnyView, pos: Pos2D) void {
        switch (self.*) {
            inline else => |*v| v.move(pos),
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
