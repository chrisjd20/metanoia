extends Control

const FONT_PATH_HEADER = "res://assets/fonts/CinzelDecorative-Bold.ttf"
const FONT_PATH_BODY = "res://assets/fonts/Cinzel.ttf"

func _ready():
	var vbox = $PanelContainer/MarginContainer/VBoxContainer
	
	vbox.get_node("BackButton").pressed.connect(_on_back_pressed)
	vbox.get_node("FullscreenToggle").toggled.connect(_on_fullscreen_toggled)
	vbox.get_node("ShakeIntensity").value_changed.connect(_on_shake_changed)
	vbox.get_node("MasterVolume").value_changed.connect(func(v): SaveManager.master_volume = v; SaveManager.save_settings())
	vbox.get_node("MusicVolume").value_changed.connect(func(v): SaveManager.music_volume = v; SaveManager.save_settings())
	vbox.get_node("SFXVolume").value_changed.connect(func(v): SaveManager.sfx_volume = v; SaveManager.save_settings())
	
	# Style the panel background
	var panel_style = StyleBoxFlat.new()
	panel_style.bg_color = Color(0.06, 0.05, 0.1, 0.85)
	panel_style.border_color = Color(0.75, 0.6, 0.25, 0.6)
	panel_style.set_border_width_all(2)
	panel_style.set_corner_radius_all(8)
	$PanelContainer.add_theme_stylebox_override("panel", panel_style)
	
	# Load fonts
	var header_font = ResourceLoader.load(FONT_PATH_HEADER)
	var body_font = ResourceLoader.load(FONT_PATH_BODY)
	
	# Header
	if header_font:
		vbox.get_node("Label").add_theme_font_override("font", header_font)
		vbox.get_node("Label").add_theme_font_size_override("font_size", 36)
		vbox.get_node("Label").add_theme_color_override("font_color", Color(0.85, 0.7, 0.3))
	
	# Body font for labels and buttons
	if body_font:
		for label_name in ["MasterLabel", "MusicLabel", "SFXLabel", "ShakeLabel"]:
			var lbl = vbox.get_node(label_name)
			lbl.add_theme_font_override("font", body_font)
			lbl.add_theme_font_size_override("font_size", 18)
			lbl.add_theme_color_override("font_color", Color(0.8, 0.75, 0.65))
		
		for btn_name in ["BackButton", "ControlsButton"]:
			var btn = vbox.get_node(btn_name)
			btn.add_theme_font_override("font", body_font)
			btn.add_theme_font_size_override("font_size", 22)
		
		vbox.get_node("FullscreenToggle").add_theme_font_override("font", body_font)
		vbox.get_node("FullscreenToggle").add_theme_font_size_override("font_size", 20)
		vbox.get_node("LanguageOption").add_theme_font_override("font", body_font)
		vbox.get_node("LanguageOption").add_theme_font_size_override("font_size", 20)
	
	# Initialize from SaveManager
	vbox.get_node("MasterVolume").value = SaveManager.master_volume
	vbox.get_node("MusicVolume").value = SaveManager.music_volume
	vbox.get_node("SFXVolume").value = SaveManager.sfx_volume
	vbox.get_node("ShakeIntensity").value = SaveManager.screen_shake_intensity * 100.0
	var is_fullscreen = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	vbox.get_node("FullscreenToggle").button_pressed = is_fullscreen

func _on_fullscreen_toggled(toggled_on: bool):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	SaveManager.fullscreen = toggled_on
	SaveManager.save_settings()

func _on_shake_changed(value: float):
	SaveManager.screen_shake_intensity = value / 100.0
	SaveManager.save_settings()

func _on_back_pressed():
	if GameManager.scene_stack.size() > 1:
		GameManager.pop_overlay()
	else:
		GameManager.transition_to_scene("res://scenes/menus/TitleScreen.tscn")
