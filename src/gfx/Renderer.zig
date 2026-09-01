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
const Widget = ui.widget.Widget;
const Color = ui.Color;

pub const Renderer = @This();

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

pub fn render(self: *Renderer, widget: *Widget) void {
    self.clear();
    _ = widget;
}
