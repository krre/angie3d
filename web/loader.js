let wasm;

const objects = {};
let objectIdCounter = 0;

let gpuId = 0;
let adapterId = 0;
let deviceId = 0;
let canvasContextId = 0;

const loadOps = ['load', 'clear'];
const storeOps = ['store', 'discard'];

function nextObjectId() {
    return ++objectIdCounter;
}

function saveObject(object) {
    const id = nextObjectId();
    objects[id] = object;
    return id;
}

function decodeUtf8(ptr, len) {
  const bytes = new Uint8Array(wasm.instance.exports.memory.buffer, ptr, len);
  const decoder = new TextDecoder('utf8');
  return decoder.decode(bytes);
}

async function gpuInit() {
    const gpu = navigator.gpu;

  if (!gpu) {
      throw new Error('User agent doesn’t support WebGPU');
    }

    gpuId = saveObject(gpu);

    const adapter = await gpu.requestAdapter();

    if (!adapter) {
        throw new Error('No WebGPU adapters found');
    }

    adapterId = saveObject(adapter);

    const device = await adapter.requestDevice();
    deviceId = saveObject(device);

    const canvas = document.querySelector('canvas');

    if (!canvas) {
        throw new Error('Canvas not found');
    }

    const canvasContext = canvas.getContext('webgpu');

    if (!canvasContext) {
        throw new Error('GPUCanvasContext object not defined');
    }

    canvasContextId = saveObject(canvasContext);

    const presentationFormat = navigator.gpu.getPreferredCanvasFormat();

    canvasContext.configure({
        device,
        format: presentationFormat,
    });
}

async function wasmInit() {
    const imports = {
        env: {
            consoleLog: (ptr, len) => {
                console.log(decodeUtf8(ptr, len));
            },
            consoleErr: (ptr, len) => {
              console.error(decodeUtf8(ptr, len));
            },
            setTitle: (ptr, len) => {
              window.document.title = decodeUtf8(ptr, len)
            },
            windowWidth: () => {
                return window.innerWidth;
            },
            windowHeight: () => {
                return window.innerHeight;
            },
            destroy: (id) => {
                objects[id].destroy()
                delete objects[id]
            },
            remove: (id) => {
                delete objects[id]
            },
            gpu: () => {
                return gpuId;
            },
            adapter: () => {
                return adapterId;
            },
            device: () => {
                return deviceId;
            },
            canvasContext: () => {
                return canvasContextId;
            },
            canvasContextGetCurrentTexture: (canvasContextId) => {
                const canvasContext = objects[canvasContextId];
                const texture = canvasContext.getCurrentTexture();
                return saveObject(texture);
            },
            textureCreateView: (textureId) => {
                const texture = objects[textureId];
                const textureView = texture.createView();
                return saveObject(textureView);
            },
            renderPassColorAttachment: (textureViewId, loadOp, storeOp, colorId) => {
                const textureView = objects[textureViewId];
                const colorAttachment = {
                    view: textureView,
                    loadOp: loadOps[loadOp],
                    storeOp: storeOps[storeOp],
                    clearValue: objects[colorId]
                };
                return saveObject(colorAttachment);
            },
            color: (r, g, b, a) => {
                const color = {
                    r: r,
                    g: g,
                    b: b,
                    a: a
                };
                return saveObject(color);
            },
            renderPassDescriptor: () => {
                const descriptor = {
                    colorAttachments: []
                };
                return saveObject(descriptor);
            },
            addRenderPassColorAttachment: (descriptorId, attachmentId) => {
                const renderPassDescriptor = objects[descriptorId];
                const renderPassColorAttachment = objects[attachmentId];
                renderPassDescriptor.colorAttachments.push(renderPassColorAttachment);
            },
            deviceCreateCommandEncoder: (deviceId) => {
                const device = objects[deviceId];
                const encoder = device.createCommandEncoder();
                return saveObject(encoder);
            },
            commandEncoderBeginRenderPass: (commandEncoderId, descriptorId) => {
                const commandEncoder = objects[commandEncoderId];
                const descriptor = objects[descriptorId];
                const renderPassEncoder = commandEncoder.beginRenderPass(descriptor);
                return saveObject(renderPassEncoder);
            },
            renderPassEnd: (renderPassId) => {
                const renderPass = objects[renderPassId];
                renderPass.end();
            },
            commandEncoderFinish: (commandEncoderId) => {
                const commandEncoder = objects[commandEncoderId];
                const commandBuffer = commandEncoder.finish();
                return saveObject(commandBuffer);
            },
            deviceQueue: (deviceId) => {
                const device = objects[deviceId];
                const queue = device.queue;
                queue.commandBuffers = [];
                return saveObject(queue);
            },
            queueAddCommandBuffer: (queueId, bufferId) => {
                const queue = objects[queueId];
                const commandBuffer = objects[bufferId];
                queue.commandBuffers.push(commandBuffer);
            },
            queueSubmit: (queueId) => {
                const queue = objects[queueId];
                queue.submit(queue.commandBuffers);
            }
        }
    };

    wasm = await WebAssembly.instantiateStreaming(fetch('lib.wasm'), imports);
}

function eventsInit() {
    const exports = wasm.instance.exports;

    window.addEventListener('resize', function () {
        exports.resize(window.innerWidth, window.innerHeight);
    });

    window.addEventListener('mousemove', function (event) {
        exports.mouseMove(event.clientX, event.clientY);
    });

    window.addEventListener('click', function (event) {
        exports.mouseClick(event.clientX, event.clientY);
    });

    window.addEventListener('dblclick', function (event) {
        exports.mouseDoubleClick(event.clientX, event.clientY);
    });

    window.addEventListener('mousedown', function (event) {
        exports.mouseDown(event.clientX, event.clientY, event.button);
    });

    window.addEventListener('mouseup', function (event) {
        exports.mouseUp(event.clientX, event.clientY, event.button);
    });

    window.addEventListener('wheel', function (event) {
        exports.mouseWheel(event.clientX, event.clientY, event.deltaY);
        event.preventDefault();
    }, { passive: false });

    window.addEventListener('contextmenu', event => event.preventDefault());

    window.addEventListener('keydown', function (event) {
        exports.keyDown(event.key.charCodeAt(0))
    });

    window.addEventListener('keyup', function (event) {
        exports.keyUp(event.key.charCodeAt(0))
    });
}

function showError(message) {
  const errorOverlay = document.getElementById('error-overlay');

  if (errorOverlay) {
      errorOverlay.textContent = message;
      errorOverlay.style.display = 'block';
  }
}

async function init() {
  try {
    await gpuInit();
    await wasmInit();
    eventsInit();
    wasm.instance.exports.start();
  } catch (e) {
    showError(e.message || String(e));
  }
}

init();
