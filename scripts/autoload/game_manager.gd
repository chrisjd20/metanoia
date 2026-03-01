extends Node

var current_scene = null
var scene_stack = []
var transition_rect: ColorRect
var selected_gender: String = "male"
var _loading_target_scene: String = ""

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS # NEVER PAUSE THE GAMEMANAGER
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	scene_stack.append(current_scene)
	
	# Setup Transition Overlay
	transition_rect = ColorRect.new()
	transition_rect.color = Color(0, 0, 0, 0) # Transparent initially
	transition_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	transition_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	transition_rect.z_index = 100 # Ensure it's on top of everything
	
	var canvas_layer = CanvasLayer.new()
	canvas_layer.layer = 100
	canvas_layer.add_child(transition_rect)
	add_child(canvas_layer)

func _fade(alpha_target: float, duration: float = 0.3) -> void:
	transition_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween = get_tree().create_tween()
	tween.tween_property(transition_rect, "color:a", alpha_target, duration)
	await tween.finished
	if alpha_target == 0.0:
		transition_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

# Standard scene replacement (Clears stack)
func transition_to_scene(res_path: String):
	get_tree().paused = false # Ensure we unpause on full transitions
	_fade(1.0) # Wait for fade first
	await get_tree().create_timer(0.35).timeout
	call_deferred("_deferred_goto_scene", res_path)

func _deferred_goto_scene(path):
	for scene in scene_stack:
		if is_instance_valid(scene):
			scene.queue_free()
	scene_stack.clear()
	
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	scene_stack.append(current_scene)
	
	_fade(0.0)

# Scene Stacking Methods (Pushing/Popping)
func push_overlay(res_path: String, pause_tree: bool = false):
	# Add an overlay without freeing the current scene
	var s = ResourceLoader.load(res_path)
	var new_scene = s.instantiate()
	get_tree().root.add_child(new_scene)
	scene_stack.append(new_scene)
	
	if pause_tree:
		get_tree().paused = true
	
	_update_current_scene_ptr()

func pop_overlay():
	if scene_stack.size() > 1:
		var top_scene = scene_stack.pop_back()
		top_scene.queue_free()
		_update_current_scene_ptr()
		
		# If the new top scene is NOT a pause menu (or similar), unpause the tree
		# Typically, returning to the base game state unpauses
		# A more robust check might involve the scene's requested process mode if complex
		if scene_stack.size() == 1:
			get_tree().paused = false

func _update_current_scene_ptr():
	if scene_stack.size() > 0:
		current_scene = scene_stack[-1]
		get_tree().current_scene = current_scene

func is_top_overlay(node: Node) -> bool:
	if scene_stack.size() > 0:
		return scene_stack[-1] == node
	return false

# Transition through a loading screen (for heavier scene changes)
func transition_to_scene_with_loading(res_path: String) -> void:
	_loading_target_scene = res_path
	transition_to_scene("res://scenes/menus/LoadingScreen.tscn")
