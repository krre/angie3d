pub const console = @import("console.zig");
pub const types = @import("types.zig");
pub const js = @import("js.zig");

pub const core = @import("core/core.zig");
pub const ui = @import("ui/ui.zig");
pub const gfx = @import("gfx/gfx.zig");

const std = @import("std");
const Application = core.Application;

pub fn App(comptime ClientApp: type) type {
    return struct {
        var host: Application = undefined;
        var client: ClientApp = undefined;

        pub fn run() void {
            host = Application.init(std.heap.wasm_allocator);
            client = ClientApp.init(&host);
            host.root_widget = client.rootWidget();
            js.event_handler = host.eventHandler();
            host.render();
        }
    };
}

pub fn runApp(comptime ClientApp: type) void {
    App(ClientApp).run();
}
