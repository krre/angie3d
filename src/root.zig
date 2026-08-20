pub const console = @import("console.zig");
pub const types = @import("types.zig");
pub const js = @import("js.zig");

pub const core = @import("core/core.zig");
pub const ui = @import("ui/ui.zig");
pub const gfx = @import("gfx/gfx.zig");

const std = @import("std");
const Application = core.Application;
const Multiverse = ui.Multiverse;
const Size2D = ui.Size2D;

pub fn App(comptime ClientApp: type) type {
    return struct {
        var host: Application = undefined;
        var client: ClientApp = undefined;

        pub fn run() !void {
            host = Application.init(std.heap.wasm_allocator);
            host.multiverse = Multiverse.init();
            client = try ClientApp.init(&host);
            js.event_handler = host.eventHandler();
            Application.resize(&host, Size2D{ .width = js.windowWidth(), .height = js.windowHeight() });
        }
    };
}

pub fn runApp(comptime ClientApp: type) void {
    App(ClientApp).run() catch |err| {
        console.err("Application error: {}\n", .{err});
    };
}
