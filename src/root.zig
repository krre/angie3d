pub const console = @import("console.zig");
pub const types = @import("types.zig");
pub const js = @import("js.zig");

pub const core = @import("core/core.zig");
pub const ui = @import("ui/ui.zig");
pub const gfx = @import("gfx/gfx.zig");

const std = @import("std");
const Application = core.Application;

var host_app: Application = undefined;

pub fn runApp(comptime App: type, allocator: std.mem.Allocator) void {
    host_app = Application.init(allocator);
    var client_app = App.init(&host_app);
    host_app.root_widget = client_app.rootWidget();
    js.event_handler = host_app.eventHandler();
    host_app.render();
}
