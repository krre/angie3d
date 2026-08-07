const EventHandler = @import("ui/EventHandler.zig");
const Id = @import("types.zig").Id;

pub var event_handler: *EventHandler = undefined;

// Events
export fn resize(width: u32, height: u32) void {
    event_handler.vtable.resize(event_handler.ptr, .{ .width = width, .height = height });
}

export fn mouseMove(x: i32, y: i32) void {
    event_handler.vtable.mouseMove(event_handler.ptr, .{ .x = x, .y = y });
}

export fn mouseClick(x: i32, y: i32) void {
    event_handler.vtable.mouseClick(event_handler.ptr, .{ .x = x, .y = y });
}

export fn mouseDoubleClick(x: i32, y: i32) void {
    event_handler.vtable.mouseDoubleClick(event_handler.ptr, .{ .x = x, .y = y });
}

export fn mouseDown(x: i32, y: i32, button: u8) void {
    event_handler.vtable.mouseDown(event_handler.ptr, .{ .x = x, .y = y }, button);
}

export fn mouseUp(x: i32, y: i32, button: u8) void {
    event_handler.vtable.mouseUp(event_handler.ptr, .{ .x = x, .y = y }, button);
}

export fn mouseWheel(x: i32, y: i32, delta_y: i8) void {
    event_handler.vtable.mouseWheel(event_handler.ptr, .{ .x = x, .y = y }, delta_y);
}

export fn keyDown(code: u32) void {
    event_handler.vtable.keyDown(event_handler.ptr, code);
}

export fn keyUp(code: u32) void {
    event_handler.vtable.keyUp(event_handler.ptr, code);
}

// Common
pub extern fn destroy(id: Id) void;
pub extern fn remove(id: Id) void;

// Window
pub extern fn setTitle(title: [*]const u8, length: usize) void;

pub extern fn windowWidth() u16;
pub extern fn windowHeight() u16;

// WebGPU
pub extern fn gpu() Id;
pub extern fn adapter() Id;
pub extern fn canvasContext() Id;
pub extern fn canvasContextGetCurrentTexture(id: Id) Id;
pub extern fn color(r: f32, g: f32, b: f32, a: f32) Id;
pub extern fn commandEncoderBeginRenderPass(id: Id, descriptor_id: Id) Id;
pub extern fn commandEncoderFinish(id: Id) Id;
pub extern fn device() Id;
pub extern fn deviceCreateCommandEncoder(id: Id) Id;
pub extern fn deviceQueue(id: Id) Id;
pub extern fn queueAddCommandBuffer(id: Id, command_buffer_id: Id) void;
pub extern fn queueSubmit(id: Id) void;
pub extern fn renderPassColorAttachment(view: Id, load_op: u8, store_op: u8, color_value: Id) Id;
pub extern fn renderPassDescriptor() Id;
pub extern fn addRenderPassColorAttachment(id: Id, attachment_id: Id) void;
pub extern fn renderPassEnd(id: Id) void;
pub extern fn destroyTexture(id: Id) void;
pub extern fn textureCreateView(id: Id) Id;
