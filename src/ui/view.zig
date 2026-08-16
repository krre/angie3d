pub const View = struct {
    pub fn update(self: *View) void {
        _ = self;
    }
};

pub const SplitView = struct {
    pub fn update(self: *SplitView) void {
        _ = self;
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
