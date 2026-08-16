const std = @import("std");
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;
const Universe = @import("Universe.zig");

pub const View = struct {
    universe: *Universe,

    pub fn init(universe: *Universe) View {
        return View{
            .universe = universe,
        };
    }

    pub fn update(self: *View) void {
        _ = self;
    }
};

pub const SplitView = struct {
    const Orientation = enum {
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

    pub fn addView(self: *SplitView, allocator: Allocator, view: AnyView) void {
        self.views.append(allocator, view);
    }

    pub fn update(self: *SplitView) void {
        for (self.views) |view| {
            view.update();
        }
    }
};

pub const AnyView = union(enum) {
    view: View,
    split_view: SplitView,

    pub fn update(self: *AnyView) void {
        switch (self.*) {
            inline else => |*v| v.update(),
        }
    }
};
