const std = @import("std");

extern fn consoleLog(message: [*]const u8, length: usize) void;
extern fn consoleErr(message: [*]const u8, length: usize) void;

pub fn log(comptime fmt: []const u8, args: anytype) void {
    const message = formatMessage(fmt, args);
    consoleLog(message.ptr, message.len);
}

pub fn err(comptime fmt: []const u8, args: anytype) void {
    const message = formatMessage(fmt, args);
    consoleErr(message.ptr, message.len);
}

fn formatMessage(comptime fmt: []const u8, args: anytype) []u8 {
    return std.fmt.allocPrint(std.heap.wasm_allocator, fmt, args) catch @panic("out of memory");
}
