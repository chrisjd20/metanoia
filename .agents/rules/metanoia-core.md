---
trigger: always_on
---

# Rules
- If you are asked a question that does not imply making edits, just answer it without making edits.

# Project Setup
- **Engine**: Godot 4.x
- **Resolution**: 1280x720 (Landscape 16:9 base), Canvas Items Stretch, Expand Aspect. The game targets wide-screen mobile play.
- **Rendering**: GL Compatibility (Mobile/WebGL targets).
- **Physics**: Jolt Physics Engine, 2D layers: Player, Enemies, Projectiles, Environment, Interactables, Triggers.
- **Input**: Virtual joysticks over touch, allowing touch-from-mouse/mouse-from-touch emulation.
- **Exports**: Android, iOS, and WebGL environments are targeted.

## UI Layout & Resolution Independence
- **CRITICAL**: Because mobile devices are incredibly varied in aspect ratio and resolution, NEVER use hardcoded pixel offsets (e.g., `offset_left = -150.0`) to position UI elements loosely on the screen.
- ALWAYS use Godot's built-in **Anchor Presets** (e.g., `PRESET_CENTER` (8), `PRESET_FULL_RECT` (15)) so UI elements stay properly rooted proportional to the screen size.
- For centering groups of buttons or text, use `VBoxContainer` or `HBoxContainer` wrapped inside a correctly anchored `Control` node or `MarginContainer`.
- Background images (`TextureRect`) should always use `layout_mode = 1` (anchors), `expand_mode = 1` (Ignore Size), and `stretch_mode = 6` (Keep Aspect Covered) so they dynamically fill all gaps on ultrawide or tall displays without distorting the art.

## AI & MCP Integration
- Cursor and Antigravity have access to the Model Context Protocol (MCP) via `godot-mcp`.
- When dealing with scenes, engine outputs, and tests, AI agents should utilize MCP tools to safely query errors and scene graph structures directly from the engine rather than just parsing raw text formatting.
- If MCP fails or is unavailable, or it doesnt provide the right tool you need, agents must fall back to standard Linux terminal tools and headless commands appropriately.

## Test / Fix Scripts

- If we create any test or one-off fix scripts, they should be placed in `./test_scripts/` . Ideally clean them up after you are done unless they are needed or are useful universally for other things.