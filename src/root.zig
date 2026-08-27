pub const console = @import("console.zig");
pub const types = @import("types.zig");
pub const js = @import("js.zig");

pub const core = @import("core/core.zig");
pub const ui = @import("ui/ui.zig");
pub const gfx = @import("gfx/gfx.zig");

const std = @import("std");
const Application = core.Application;
const Size2D = ui.Size2D;

pub fn App(comptime ClientApp: type) type {
    return struct {
        var host: Application = undefined;
        var client: ClientApp = undefined;

        pub fn run() !void {
            host = Application.init(std.heap.wasm_allocator);
            client = try ClientApp.init(&host);
            js.app = &host;
        }
    };
}

pub fn runApp(comptime ClientApp: type) void {
    App(ClientApp).run() catch |err| {
        console.err("Application error: {}\n", .{err});
    };
}

test "root reference declarations" {
    std.testing.refAllDecls(console);
    std.testing.refAllDecls(types);
    std.testing.refAllDecls(core);
    std.testing.refAllDecls(ui);
    std.testing.refAllDecls(gfx);
}
