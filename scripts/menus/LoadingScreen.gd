extends Control

const SCRIPTURE_QUOTES = [
	"\"Be strong and courageous. Do not be afraid.\"\n— Joshua 1:9",
	"\"The Lord is my shepherd; I shall not want.\"\n— Psalm 23:1",
	"\"I can do all things through Christ who strengthens me.\"\n— Philippians 4:13",
	"\"For God has not given us a spirit of fear, but of power.\"\n— 2 Timothy 1:7",
	"\"The light shines in the darkness, and the darkness has not overcome it.\"\n— John 1:5",
	"\"Put on the whole armor of God, that you may be able to stand.\"\n— Ephesians 6:11",
	"\"Trust in the Lord with all your heart.\"\n— Proverbs 3:5",
	"\"He who is in you is greater than he who is in the world.\"\n— 1 John 4:4",
	"\"No weapon formed against you shall prosper.\"\n— Isaiah 54:17",
	"\"The Lord is my light and my salvation; whom shall I fear?\"\n— Psalm 27:1",
]

var target_scene_path: String = ""

func _ready():
	# Get the target scene from GameManager
	target_scene_path = GameManager._loading_target_scene
	GameManager._loading_target_scene = ""
	
	# Random scripture quote
	var quote = SCRIPTURE_QUOTES[randi() % SCRIPTURE_QUOTES.size()]
	$CenterContainer/VBoxContainer/ScriptureLabel.text = quote
	
	# Fonts
	var body_font = ResourceLoader.load("res://assets/fonts/Cinzel.ttf")
	if body_font:
		$CenterContainer/VBoxContainer/ScriptureLabel.add_theme_font_override("font", body_font)
		$CenterContainer/VBoxContainer/ScriptureLabel.add_theme_font_size_override("font_size", 20)
		$CenterContainer/VBoxContainer/ScriptureLabel.add_theme_color_override("font_color", Color(0.85, 0.7, 0.3))
		$CenterContainer/VBoxContainer/LoadingLabel.add_theme_font_override("font", body_font)
		$CenterContainer/VBoxContainer/LoadingLabel.add_theme_font_size_override("font_size", 16)
		$CenterContainer/VBoxContainer/LoadingLabel.add_theme_color_override("font_color", Color(0.6, 0.55, 0.45))
	
	# Style progress bar
	var bg_style = StyleBoxFlat.new()
	bg_style.bg_color = Color(0.15, 0.12, 0.18)
	bg_style.set_corner_radius_all(4)
	$CenterContainer/VBoxContainer/ProgressBar.add_theme_stylebox_override("background", bg_style)
	
	var fill_style = StyleBoxFlat.new()
	fill_style.bg_color = Color(0.85, 0.7, 0.3)
	fill_style.set_corner_radius_all(4)
	$CenterContainer/VBoxContainer/ProgressBar.add_theme_stylebox_override("fill", fill_style)
	
	# Start loading the target scene
	if target_scene_path != "":
		ResourceLoader.load_threaded_request(target_scene_path)
	else:
		# No target scene — just show for a moment then go to title
		_fake_load()

func _process(_delta):
	if target_scene_path == "":
		return
	
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(target_scene_path, progress)
	
	if progress.size() > 0:
		$CenterContainer/VBoxContainer/ProgressBar.value = progress[0] * 100.0
	
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		var scene = ResourceLoader.load_threaded_get(target_scene_path)
		if scene:
			$CenterContainer/VBoxContainer/ProgressBar.value = 100.0
			# Brief pause to show 100%
			await get_tree().create_timer(0.3).timeout
			_goto_scene(scene)
	elif status == ResourceLoader.THREAD_LOAD_FAILED:
		push_error("Failed to load scene: " + target_scene_path)
		GameManager.transition_to_scene("res://scenes/menus/TitleScreen.tscn")

func _goto_scene(scene_resource: Resource):
	# Replace the current scene with the loaded one
	var instance = scene_resource.instantiate()
	
	# Clear the stack and switch
	for s in GameManager.scene_stack:
		if is_instance_valid(s):
			s.queue_free()
	GameManager.scene_stack.clear()
	
	get_tree().root.add_child(instance)
	get_tree().current_scene = instance
	GameManager.current_scene = instance
	GameManager.scene_stack.append(instance)

func _fake_load():
	var tween = create_tween()
	tween.tween_property($CenterContainer/VBoxContainer/ProgressBar, "value", 100.0, 1.5)
	await tween.finished
	GameManager.transition_to_scene("res://scenes/menus/TitleScreen.tscn")
