const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "LinkedListApp",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const tests = b.addTest(.{
        .root_source_file = b.path("test/test.zig"),
        .target = target,
        .optimize = optimize,
    });

    const linkedlist_mod = b.createModule(.{
        .root_source_file = b.path("src/linkedlist.zig"),
    });
    tests.root_module.addImport("linkedlist", linkedlist_mod);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&tests.step);
}
