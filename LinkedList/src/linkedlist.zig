const std = @import("std");

// -------------------------------------------------------------
//                         LINKED LIST
// -------------------------------------------------------------

pub fn LinkedList(T: type) type {
    return struct {
        const Self = @This();

        // Definiting LL Nodes
        pub const Node = struct {
            data: T,
            next: ?*Node,
            prev: ?*Node,
        }; // end Node struct

        // LL members
        head: ?*Node,
        tail: ?*Node,
        len: usize,
        allocator: std.mem.Allocator,

        const err = error{
            EmptyList,
            NotFound,
        }; // end error struct

        // Init function for LL Data Structure
        pub fn init(alloc: std.mem.Allocator) Self {
            return .{
                .head = null,
                .tail = null,
                .len = 0,
                .allocator = alloc,
            };
        } // end init

        // Deinit function to clean up LL Data Structure
        pub fn deinit(self: *Self) void {
            var temp = self.head;

            while (temp) |node| {
                const next = node.next;
                self.allocator.destroy(node);
                temp = next;
            }

            self.head = null;
            self.tail = null;
            self.len = 0;
        } // end deinit

        // Insert function
        pub fn insert(self: *Self, val: T) !void {

            // Create new node
            // Asks allocator to allocate enough memory to hold a new Node
            // Adding new node to tail of list
            const newNode = try self.allocator.create(Node);
            newNode.* = Node{
                .data = val,
                .next = null,
                .prev = null,
            };

            if (self.head == null) {
                self.head = newNode;
                self.tail = newNode;
            } else {

                // Unwrap optional tail pointer
                self.tail.?.next = newNode;
                newNode.prev = self.tail;
                self.tail = newNode;
            } // end if-else

            self.len += 1;
        } // end insert

        // Remove function
        pub fn remove(self: *Self, val: T) !void {
            if (self.head == null) {
                return err.EmptyList;
            }

            // Find node to remove
            const temp = self.find(val) orelse return err.NotFound;

            // 3 cases to consider:
            // - Node is head
            // - Node is somewhere in middle
            // - Node is tail

            // Node is head
            if (temp == self.head) {
                if (self.head.?.next) |nextNode| {
                    nextNode.prev = null;
                }
                self.head = self.head.?.next;
            } else if (temp == self.tail) {
                if (self.tail.?.prev) |prevNode| {
                    prevNode.next = null;
                }
                self.tail = self.tail.?.prev;
            } else { // This means its neither the head nor tail
                temp.prev.?.next = temp.next;
                temp.next.?.prev = temp.prev;
            }

            // Obliterate the node to be removed
            self.allocator.destroy(temp);
            self.len -= 1;
        } // end remove

        // Find function
        // ?*Node: Node may or may not exist
        pub fn find(self: *Self, val: T) ?*Node {
            // _ = self;
            // _ = val;

            // var temp: ?*Node = self.head;
            var temp = self.head;

            while (temp) |node| {
                if (val == node.data) {
                    return temp;
                }

                temp = node.next;
            }

            return null;
        } // end find

        // Length function
        pub fn length(self: *Self) u32 {
            const result: u32 = @intCast(self.len);
            return result;
        } // end length
    }; // end initial return struct
} // end LinkedList
