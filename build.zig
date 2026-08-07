const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.addModule("angie3d", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    mod.export_symbol_names = &[_][]const u8{
        "start",
        "resize",
        "mouseMove",
        "mouseClick",
        "mouseDoubleClick",
        "mouseDown",
        "mouseUp",
        "mouseWheel",
        "keyDown",
        "keyUp",
    };

    const mod_tests = b.addTest(.{
        .root_module = mod,
    });

    const run_mod_tests = b.addRunArtifact(mod_tests);

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_mod_tests.step);
}
