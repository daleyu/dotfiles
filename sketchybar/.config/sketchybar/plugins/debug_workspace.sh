#!/bin/bash
# Debug script to check AeroSpace window distribution
echo "=== AeroSpace Window Distribution ==="
for i in {1..8}; do
    echo "Workspace $i:"
    aerospace list-windows --workspace "$i" | grep -v "^No windows"
    echo "---"
done
