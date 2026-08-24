const std = @import("std");
const js = @import("js.zig");

pub fn log(comptime fmt: []const u8, args: anytype) void {
    const message = formatMessage(fmt, args);
    js.consoleLog(message.ptr, message.len);
}

pub fn err(comptime fmt: []const u8, args: anytype) void {
    const message = formatMessage(fmt, args);
    js.consoleErr(message.ptr, message.len);
}

fn formatMessage(comptime fmt: []const u8, args: anytype) []u8 {
    return std.fmt.allocPrint(std.heap.wasm_allocator, fmt, args) catch @panic("out of memory");
}
