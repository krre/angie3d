const std = @import("std");

const geometry = @import("geometry.zig");
const Pos2D = geometry.Pos2D;
const Size2D = geometry.Size2D;

const EventHandler = @This();

ptr: *anyopaque,
vtable: *const VTable,

pub const VTable = struct {
    resize: *const fn (*anyopaque, size: Size2D) void,
    mouseMove: *const fn (*anyopaque, pos: Pos2D) void,
    mouseClick: *const fn (*anyopaque, pos: Pos2D) void,
    mouseDoubleClick: *const fn (*anyopaque, pos: Pos2D) void,
    mouseDown: *const fn (*anyopaque, pos: Pos2D, button: u8) void,
    mouseUp: *const fn (*anyopaque, pos: Pos2D, button: u8) void,
    mouseWheel: *const fn (*anyopaque, pos: Pos2D, delta_y: i8) void,
    keyDown: *const fn (*anyopaque, code: u32) void,
    keyUp: *const fn (*anyopaque, code: u32) void,
};

pub fn init(ptr: *anyopaque, vtable: *const VTable) EventHandler {
    return EventHandler{
        .ptr = ptr,
        .vtable = vtable,
    };
}
