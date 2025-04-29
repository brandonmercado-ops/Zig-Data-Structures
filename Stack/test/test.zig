const std = @import("std");
const testing = std.testing;

test "always succeed" {
    try testing.expect(true);
}
