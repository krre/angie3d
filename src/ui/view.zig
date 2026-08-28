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

    pub fn deinit(self: *View, allocator: Allocator) void {
        _ = self;
        _ = allocator;
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

    pub fn deinit(self: *SplitView, allocator: Allocator) void {
        for (self.views.items) |*view| {
            view.deinit(allocator);
        }

        self.views.deinit(allocator);
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

            if (self.orientation == .horizontal) {
                view_size.width = size.width / views_count;
                view_pos.x = @as(i32, @intCast(view_size.width * i));
            } else if (self.orientation == .vertical) {
                view_size.height = size.height / views_count;
                view_pos.y = @as(i32, @intCast(view_size.height * i));
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
        for (self.views.items) |*view| {
            view.update();
        }
    }
};

pub const AnyView = union(enum) {
    view: View,
    split_view: SplitView,

    pub fn deinit(self: *AnyView, allocator: Allocator) void {
        switch (self.*) {
            inline else => |*view| view.deinit(allocator),
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

test "SplitView.resize horizontal" {
    var split_view = SplitView.init(.horizontal);

    const view1 = View.init(undefined);
    const view2 = View.init(undefined);

    try split_view.addView(std.testing.allocator, .{ .view = view1 });
    try split_view.addView(std.testing.allocator, .{ .view = view2 });

    defer split_view.deinit(std.testing.allocator);

    split_view.resize(.{
        .width = 100,
        .height = 50,
    });

    try std.testing.expectEqual(@as(u32, 100), split_view.size.width);
    try std.testing.expectEqual(@as(u32, 50), split_view.size.height);

    try std.testing.expectEqual(@as(u32, 50), split_view.views.items[0].view.size.width);
    try std.testing.expectEqual(@as(u32, 50), split_view.views.items[1].view.size.width);

    try std.testing.expectEqual(@as(i32, 0), split_view.views.items[0].view.pos.x);
    try std.testing.expectEqual(@as(i32, 50), split_view.views.items[1].view.pos.x);
}

test "SplitView.resize vertical" {
    var split_view = SplitView.init(.vertical);

    const view1 = View.init(undefined);
    const view2 = View.init(undefined);
    const view3 = View.init(undefined);

    try split_view.addView(std.testing.allocator, .{ .view = view1 });
    try split_view.addView(std.testing.allocator, .{ .view = view2 });
    try split_view.addView(std.testing.allocator, .{ .view = view3 });

    defer split_view.deinit(std.testing.allocator);

    split_view.resize(.{
        .width = 100,
        .height = 120,
    });

    try std.testing.expectEqual(@as(u32, 100), split_view.size.width);
    try std.testing.expectEqual(@as(u32, 120), split_view.size.height);

    try std.testing.expectEqual(@as(u32, 40), split_view.views.items[0].view.size.height);
    try std.testing.expectEqual(@as(u32, 40), split_view.views.items[1].view.size.height);
    try std.testing.expectEqual(@as(u32, 40), split_view.views.items[2].view.size.height);

    try std.testing.expectEqual(@as(i32, 0), split_view.views.items[0].view.pos.y);
    try std.testing.expectEqual(@as(i32, 40), split_view.views.items[1].view.pos.y);
    try std.testing.expectEqual(@as(i32, 80), split_view.views.items[2].view.pos.y);
}
