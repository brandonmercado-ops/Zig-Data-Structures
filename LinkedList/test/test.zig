const std = @import("std");
const LinkedList = @import("linkedlist").LinkedList;

// -------------------------------------------------------------
//                            TESTING
// -------------------------------------------------------------

test "insert and length" {
    const allocator = std.heap.page_allocator;
    var linkedList = LinkedList(i32).init(allocator);

    _ = try linkedList.insert(10);
    _ = try linkedList.insert(100);
    _ = try linkedList.insert(1000);

    try std.testing.expect(linkedList.length() == 3);
}

test "find" {
    const allocator = std.heap.page_allocator;
    var linkedList = LinkedList(i32).init(allocator);

    _ = try linkedList.insert(1);
    _ = try linkedList.insert(10);
    _ = try linkedList.insert(100);

    const temp = linkedList.find(10);

    try std.testing.expect(temp != null);
    try std.testing.expect(temp.?.data == 10);
    try std.testing.expect(temp.?.prev.?.data == 1);
    try std.testing.expect(temp.?.next.?.data == 100);
}

test "remove" {
    const allocator = std.heap.page_allocator;
    var linkedList = LinkedList(i32).init(allocator);

    _ = try linkedList.insert(1);
    _ = try linkedList.insert(10);
    _ = try linkedList.insert(100);
    _ = try linkedList.insert(10_000);

    try std.testing.expect(linkedList.length() == 4);

    _ = try linkedList.remove(10_000);

    try std.testing.expect(linkedList.length() == 3);
}
