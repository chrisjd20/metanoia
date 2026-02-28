---
trigger: always_on
---

# Rules
- If you are asked a question that does not imply making edits, just answer it without making edits.

# Project Setup
- **Engine**: Godot 4.x
- **Resolution**: 1080x1920 (Portrait), Canvas Items Stretch, Expand Aspect.
- **Rendering**: GL Compatibility (Mobile/WebGL targets).
- **Physics**: Jolt Physics Engine, 2D layers: Player, Enemies, Projectiles, Environment, Interactables, Triggers.
- **Input**: Virtual joysticks over touch, allowing touch-from-mouse/mouse-from-touch emulation.
- **Exports**: Android, iOS, and WebGL environments are targeted.

## AI & MCP Integration
- Cursor and Antigravity have access to the Model Context Protocol (MCP) via `godot-mcp`.
- When dealing with scenes, engine outputs, and tests, AI agents should utilize MCP tools to safely query errors and scene graph structures directly from the engine rather than just parsing raw text formatting.
- If MCP fails or is unavailable, or it doesnt provide the right tool you need, agents must fall back to standard Linux terminal tools and headless commands appropriately.

## Test / Fix Scripts

- If we create any test or one-off fix scripts, they should be placed in `./test_scripts/` . Ideally clean them up after you are done unless they are needed or are useful universally for other things.