# Build examples
build:
    zig build examples

# Run tests
test:
    zig build test

# Run hello-world example
[working-directory('zig-out/examples/hello-world/web')]
hello-world:
    python3 -m http.server 8000 --bind 127.0.0.1

# Cleanup all
[working-directory('zig-out')]
clean:
    rm -rf examples
