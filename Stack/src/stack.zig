const std = @import("std");

// -------------------------------------------------------------
//                           STACK
// -------------------------------------------------------------

pub fn Stack(T: type) type {
    return struct {
        const Self = @This();

        // Definiting LL Nodes
        pub const Node = struct {
            data: T,
            // next: ?*Node,
            // prev: ?*Node,
        }; // end Node struct

        // Stack members
        head: ?*Node,
        tail: ?*Node,
        len: usize,
        allocator: std.mem.Allocator,

        const err = error{
            EmptyStack,
            NotFound,
        }; // end error struct

        // Init function for Stack Data Structure
        pub fn init(alloc: std.mem.Allocator) Self {
            return .{
                .head = null,
                .tail = null,
                .len = 0,
                .allocator = alloc,
            };
        } // end init

        // Deinit function to clean up Stack Data Structure
        pub fn deinit(self: *Self) void {
            _ = self;
        } // end deinit

        // Pop function
        pub fn push(self: *Self, val: T) !void {
            _ = self;
            _ = val;
        } // end push

        // Pop function
        pub fn pop(self: *Self, val: T) !void {
            _ = self;
            _ = val;
        } // end pop

        // Peak function
        // ?*Node: Node may or may not exist
        pub fn peak(self: *Self) ?*Node {
            _ = self;
            return null;
        } // end peak

        // Length function
        pub fn length(self: *Self) u32 {
            const result: u32 = @intCast(self.len);
            return result;
        } // end length
    }; // end initial return struct
}
