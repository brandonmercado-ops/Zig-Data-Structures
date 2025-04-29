#!/usr/bin/env bash
rm -rf zig-out .zig-cache

if [ "$1" = "test" ]; then
	shift
	zig build test --summary all "$@"
else 
	zig build "$@"
fi
