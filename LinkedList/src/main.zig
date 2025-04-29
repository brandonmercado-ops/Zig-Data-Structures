const std = @import("std");
const LinkedList = @import("linkedlist.zig").LinkedList;

// -------------------------------------------------------------
//                        MAIN FUNCITION
// -------------------------------------------------------------

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var list = LinkedList(i32).init(allocator);
    defer list.deinit();

    _ = try list.insert(10);
    _ = try list.insert(20);

    std.debug.print("List length: {}\n", .{list.length()});
}
