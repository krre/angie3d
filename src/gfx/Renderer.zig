const webgpu = @import("webgpu/webgpu.zig");
const Gpu = webgpu.Gpu;
const GpuAdapter = webgpu.GpuAdapter;
const GpuColor = webgpu.GpuColor;
const GpuCommandEncoder = webgpu.GpuCommandEncoder;
const GpuCommandBuffer = webgpu.GpuCommandBuffer;
const GpuDevice = webgpu.GpuDevice;
const GpuRenderPassColorAttachment = webgpu.GpuRenderPassColorAttachment;
const GpuRenderPassDescriptor = webgpu.GpuRenderPassDescriptor;
const GpuCanvasContext = webgpu.GpuCanvasContext;
const GpuLoadOp = webgpu.GpuLoadOp;
const GpuStoreOp = webgpu.GpuStoreOp;

const ui = @import("../ui/ui.zig");
const AnyView = @import("../ui/view.zig").AnyView;
const Node = ui.node.Node;
const Color = ui.Color;
const geometry = @import("../ui/geometry.zig");
const Rect = geometry.Rect;
const Pos2D = geometry.Pos2D;

const std = @import("std");
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;

pub const Renderer = @This();

const RenderTarget = struct {
    scene: *Node,
    rect: Rect,
};

gpu: Gpu,
adapter: GpuAdapter,
device: GpuDevice,
canvas_context: GpuCanvasContext,

pub fn init() Renderer {
    return Renderer{
        .gpu = Gpu.init(),
        .adapter = GpuAdapter.init(),
        .device = GpuDevice.init(),
        .canvas_context = GpuCanvasContext.init(),
    };
}

pub fn clear(self: *Renderer) void {
    const texture = self.canvas_context.getCurrentTexture();
    defer texture.deinit();

    const texture_view = texture.createView();
    defer texture_view.deinit();

    const color = GpuColor.init(Color.gray);

    const color_attachment = GpuRenderPassColorAttachment.init(texture_view, .clear, .store, color);
    defer color_attachment.deinit();

    const render_pass_descriptor = GpuRenderPassDescriptor.init();
    defer render_pass_descriptor.deinit();

    render_pass_descriptor.addColorAttachment(color_attachment);

    const command_encoder = self.device.createCommandEncoder();
    defer command_encoder.deinit();

    const render_pass = command_encoder.beginRenderPass(render_pass_descriptor);
    defer render_pass.deinit();

    render_pass.end();

    const command_buffer = command_encoder.finish();
    defer command_buffer.deinit();

    const queue = self.device.queue();
    defer queue.deinit();

    queue.submit(&[_]GpuCommandBuffer{command_buffer});
}

pub fn render(self: *Renderer, allocator: std.mem.Allocator, view: AnyView) !void {
    _ = self;
    var render_targets = ArrayList(RenderTarget).empty;
    try collectRenderTargets(allocator, view, .{}, &render_targets);
}

fn collectRenderTargets(allocator: std.mem.Allocator, view: AnyView, parent_pos: Pos2D, render_targets: *ArrayList(RenderTarget)) !void {
    switch (view) {
        .split_view => |sv| {
            const pos: Pos2D = .{ .x = sv.rect.pos.x + parent_pos.x, .y = sv.rect.pos.y + parent_pos.y };

            for (sv.views.items) |v| {
                try collectRenderTargets(allocator, v, pos, render_targets);
            }
        },
        .view => |v| {
            const pos: Pos2D = .{ .x = v.rect.pos.x + parent_pos.x, .y = v.rect.pos.y + parent_pos.y };
            const render_target: RenderTarget = .{
                .rect = .{ .pos = pos, .size = v.rect.size },
                .scene = v.scene,
            };
            try render_targets.append(allocator, render_target);
        },
    }
}
