extends Control

var _desaturate_tween: Tween

const TEMPTER_LINES = [
	"\"You'll just die again.\"",
	"\"Was it worth it?\"",
	"\"No one is coming to save you.\"",
	"\"Give up. It's easier.\"",
	"\"How predictable.\"",
	"\"The darkness always wins.\"",
]

func _ready():
	$VBoxContainer/AbsolutionButton.pressed.connect(_on_absolution_pressed)
	
	var font_gothic = ResourceLoader.load("res://assets/fonts/Cinzel.ttf")
	if font_gothic:
		$VBoxContainer/AbsolutionButton.add_theme_font_override("font", font_gothic)
		$VBoxContainer/AbsolutionButton.add_theme_font_size_override("font_size", 36)
		$VBoxContainer/AbsolutionButton.add_theme_color_override("font_color", Color(0.9, 0.85, 0.7))
		$VBoxContainer/AbsolutionButton.add_theme_color_override("font_hover_color", Color(1.0, 0.9, 0.5))
		$VBoxContainer/TempterLabel.add_theme_font_override("font", font_gothic)
		$VBoxContainer/TempterLabel.add_theme_font_size_override("font_size", 22)
		$VBoxContainer/TempterLabel.add_theme_color_override("font_color", Color(0.7, 0.3, 0.3))
	
	var tex = ResourceLoader.load("res://assets/art/environment/death_screen_bg.png")
	if tex:
		$Background.texture = tex
	
	# Random tempter line
	$VBoxContainer/TempterLabel.text = TEMPTER_LINES[randi() % TEMPTER_LINES.size()]
	
	# Desaturation / darken effect on enter
	modulate = Color(0.5, 0.5, 0.6, 0.0)
	_desaturate_tween = create_tween()
	_desaturate_tween.tween_property(self , "modulate", Color(0.7, 0.65, 0.7, 1.0), 1.5).set_ease(Tween.EASE_OUT)

func _on_absolution_pressed():
	# Brief absolution animation: white flash then fade out
	var flash_rect = ColorRect.new()
	flash_rect.color = Color(1, 1, 0.9, 0.0)
	flash_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	flash_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(flash_rect)
	
	var tween = create_tween()
	# Flash white
	tween.tween_property(flash_rect, "color:a", 0.8, 0.3)
	# Hold briefly
	tween.tween_interval(0.5)
	# Fade out
	tween.tween_property(flash_rect, "color:a", 0.0, 0.5)
	tween.tween_callback(_respawn)

func _respawn():
	# TODO: When checkpoints exist, respawn at last Priest Checkpoint
	# For now, return to title screen as no checkpoint system is built yet
	GameManager.transition_to_scene("res://scenes/menus/TitleScreen.tscn")
