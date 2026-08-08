const std = @import("std");

const angie3d = "angie3d";

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.addModule(angie3d, .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    mod.export_symbol_names = &[_][]const u8{
        "main",
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

    const examples_step = b.step(
        "examples",
        "Build all examples",
    );

    addExample(
        b,
        "hello-world",
        optimize,
        mod,
        examples_step,
    );
}

fn addExample(
    b: *std.Build,
    comptime name: []const u8,
    optimize: std.builtin.OptimizeMode,
    angie3d_mod: *std.Build.Module,
    examples_step: *std.Build.Step,
) void {
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .wasm32,
        .os_tag = .freestanding,
    });

    const example = b.addExecutable(.{
        .name = name,
        .root_module = b.createModule(.{
            .root_source_file = b.path(
                b.fmt("examples/{s}/src/root.zig", .{name}),
            ),
            .target = target,
            .optimize = optimize,
        }),
    });

    example.entry = .disabled;
    example.root_module.addImport(angie3d, angie3d_mod);
    example.root_module.export_symbol_names = angie3d_mod.export_symbol_names;

    const install_wasm = b.addInstallArtifact(example, .{
        .dest_dir = .{
            .override = .{
                .custom = b.fmt("examples/{s}/web", .{name}),
            },
        },
        .dest_sub_path = "lib.wasm",
    });

    const install_angie3d_web = b.addInstallDirectory(.{
        .source_dir = b.path("web"),
        .install_dir = .prefix,
        .install_subdir = b.fmt(
            "examples/{s}/web",
            .{name},
        ),
    });

    install_angie3d_web.step.dependOn(&install_wasm.step);

    const example_step = b.step(
        b.fmt("{s}", .{name}),
        b.fmt("Build {s} example", .{name}),
    );

    example_step.dependOn(&install_angie3d_web.step);

    examples_step.dependOn(example_step);
}
