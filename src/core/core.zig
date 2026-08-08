const std = @import("std");
const js = @import("../js.zig");

pub const Application = @import("Application.zig");
pub const EventHandler = @import("EventHandler.zig");

var host_app: Application = undefined;

pub fn runApp(comptime App: type, allocator: std.mem.Allocator) void {
    host_app = Application.init(allocator);
    var client_app = App.init(&host_app);
    host_app.root_widget = client_app.rootWidget();
    js.event_handler = host_app.eventHandler();
    host_app.render();
}
