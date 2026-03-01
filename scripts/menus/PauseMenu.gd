extends Control

func _ready():
	$VBoxContainer/ResumeButton.pressed.connect(_on_resume_pressed)
	$VBoxContainer/SettingsButton.pressed.connect(_on_settings_pressed)
	$VBoxContainer/ReturnButton.pressed.connect(_on_return_pressed)
	$ConfirmationDialog.confirmed.connect(_on_return_confirmed)
	
	var header_font = ResourceLoader.load("res://assets/fonts/CinzelDecorative-Bold.ttf")
	var body_font = ResourceLoader.load("res://assets/fonts/Cinzel.ttf")
	if header_font:
		$VBoxContainer/Label.add_theme_font_override("font", header_font)
		$VBoxContainer/Label.add_theme_font_size_override("font_size", 40)
		$VBoxContainer/Label.add_theme_color_override("font_color", Color(0.85, 0.7, 0.3))
	if body_font:
		for btn in [$VBoxContainer/ResumeButton, $VBoxContainer/SettingsButton, $VBoxContainer/ReturnButton]:
			btn.add_theme_font_override("font", body_font)
			btn.add_theme_font_size_override("font_size", 26)
	
	# The pause menu itself should be able to run while paused
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	# Allow hitting ESC to unpause if it's the top overlay
	if event.is_action_pressed("ui_cancel") and GameManager.is_top_overlay(self ):
		_on_resume_pressed()
		get_viewport().set_input_as_handled()

func _on_resume_pressed():
	GameManager.pop_overlay()

func _on_settings_pressed():
	GameManager.push_overlay("res://scenes/menus/SettingsMenu.tscn")

func _on_return_pressed():
	$ConfirmationDialog.popup_centered()

func _on_return_confirmed():
	# Ensure time is unpaused before returning
	get_tree().paused = false
	GameManager.transition_to_scene("res://scenes/menus/TitleScreen.tscn")
