const std = @import("std");
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;
const Node = @import("node/node.zig").Node;
const geometry = @import("geometry.zig");
const Size2D = geometry.Size2D;
const Pos2D = geometry.Pos2D;

pub const View = struct {
    scene: *Node,
    size: Size2D,
    pos: Pos2D,

    pub fn init(scene: *Node) View {
        return View{
            .scene = scene,
            .size = .{},
            .pos = .{},
        };
    }

    pub fn deinit(self: *SplitView) void {
        _ = self;
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
    pub const Direction = enum {
        horizontal,
        vertical,
        layer,
    };

    orientation: Direction,
    views: ArrayList(AnyView),
    size: Size2D,
    pos: Pos2D,

    pub fn init(orientation: Direction) SplitView {
        return SplitView{
            .orientation = orientation,
            .views = ArrayList(AnyView).empty,
            .size = .{},
            .pos = .{},
        };
    }

    pub fn deinit(self: *SplitView) void {
        for (self.views.items) |view| {
            view.deinit();
        }

        self.views.deinit();
    }

    pub fn addView(self: *SplitView, allocator: Allocator, view: AnyView) !void {
        try self.views.append(allocator, view);
    }

    pub fn resize(self: *SplitView, size: Size2D) void {
        self.size = size;
        const views_count = @as(u32, @intCast(self.views.items.len));

        for (self.views.items, 0..) |*view, i| {
            var view_size = size;
            var view_pos = view.getPos();

            if (self.orientation == Direction.horizontal) {
                view_size.width = size.width / views_count;
                view_pos.x = @as(i32, @intCast(view_size.width * i));
            } else if (self.orientation == Direction.vertical) {
                view_size.height = size.height / views_count;
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

    pub fn deinit(self: *AnyView) void {
        switch (self.*) {
            inline else => |*view| view.deinit(),
        }
    }

    pub fn getPos(self: *AnyView) Pos2D {
        return switch (self.*) {
            inline else => |*view| view.pos,
        };
    }

    pub fn resize(self: *AnyView, size: Size2D) void {
        switch (self.*) {
            inline else => |*view| view.resize(size),
        }
    }

    pub fn move(self: *AnyView, pos: Pos2D) void {
        switch (self.*) {
            inline else => |*view| view.move(pos),
        }
    }

    pub fn render(self: *AnyView) void {
        switch (self.*) {
            inline else => |*view| view.render(),
        }
    }

    pub fn update(self: *AnyView) void {
        switch (self.*) {
            inline else => |*view| view.update(),
        }
    }
};
