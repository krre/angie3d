const Application = @import("core/Application.zig");
const Id = @import("types.zig").Id;

pub var app: *Application = undefined;

// Events
export fn resize(width: u32, height: u32) void {
    app.resize(.{ .width = width, .height = height });
}

export fn mouseMove(x: i32, y: i32) void {
    app.mouseMove(.{ .x = x, .y = y });
}

export fn mouseClick(x: i32, y: i32) void {
    app.mouseClick(.{ .x = x, .y = y });
}

export fn mouseDoubleClick(x: i32, y: i32) void {
    app.mouseDoubleClick(.{ .x = x, .y = y });
}

export fn mouseDown(x: i32, y: i32, button: u8) void {
    app.mouseDown(.{ .x = x, .y = y }, button);
}

export fn mouseUp(x: i32, y: i32, button: u8) void {
    app.mouseUp(.{ .x = x, .y = y }, button);
}

export fn mouseWheel(x: i32, y: i32, delta_y: i8) void {
    app.mouseWheel(.{ .x = x, .y = y }, delta_y);
}

export fn keyDown(code: u32) void {
    app.keyDown(code);
}

export fn keyUp(code: u32) void {
    app.keyUp(code);
}

// Common
pub extern fn destroy(id: Id) void;
pub extern fn remove(id: Id) void;

// Window
pub extern fn setTitle(title: [*]const u8, length: usize) void;

// Console
pub extern fn consoleLog(message: [*]const u8, length: usize) void;
pub extern fn consoleErr(message: [*]const u8, length: usize) void;

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
pub extern fn queueSubmit(id: Id, command_buffers_ptr: [*]const u8, command_buffers_length: usize) void;
pub extern fn renderPassColorAttachment(view: Id, load_op: u8, store_op: u8, color_value: Id) Id;
pub extern fn renderPassDescriptor() Id;
pub extern fn addRenderPassColorAttachment(id: Id, attachment_id: Id) void;
pub extern fn renderPassSetViewport(id: Id, x: f32, y: f32, width: f32, height: f32, minDepth: f32, maxDepth: f32) void;
pub extern fn renderPassSetScissorRect(id: Id, x: u32, y: u32, width: u32, height: u32) void;
pub extern fn renderPassEnd(id: Id) void;
pub extern fn destroyTexture(id: Id) void;
pub extern fn textureCreateView(id: Id) Id;
