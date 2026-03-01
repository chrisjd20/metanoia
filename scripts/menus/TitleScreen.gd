extends Control

func _ready():
	$VBoxContainer/NewGameButton.pressed.connect(_on_new_game_pressed)
	$VBoxContainer/ContinueButton.pressed.connect(_on_continue_pressed)
	$VBoxContainer/SettingsButton.pressed.connect(_on_settings_pressed)
	$VBoxContainer/CreditsButton.pressed.connect(_on_credits_pressed)
	$VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)
	
	# Grey out Continue if no save exists
	$VBoxContainer/ContinueButton.disabled = not SaveManager.has_save()
	
	# Hide Quit on mobile/web
	if OS.has_feature("web") or OS.has_feature("mobile"):
		$VBoxContainer/QuitButton.visible = false
	
	# Fonts
	var font = ResourceLoader.load("res://assets/fonts/Cinzel.ttf")
	var header_font = ResourceLoader.load("res://assets/fonts/CinzelDecorative-Bold.ttf")
	if font:
		for btn in $VBoxContainer.get_children():
			if btn is Button:
				btn.add_theme_font_override("font", font)
				btn.add_theme_font_size_override("font_size", 26)
				btn.add_theme_color_override("font_color", Color(0.9, 0.85, 0.7))
				btn.add_theme_color_override("font_hover_color", Color(1.0, 0.9, 0.5))
	
	# Tagline styling
	if font:
		$TaglineLabel.add_theme_font_override("font", font)
		$TaglineLabel.add_theme_font_size_override("font_size", 26)
		$TaglineLabel.add_theme_color_override("font_color", Color(0.9, 0.85, 0.65, 1.0))
		$TaglineLabel.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0, 1.0))
		$TaglineLabel.add_theme_constant_override("outline_size", 12)
		$TaglineLabel.add_theme_constant_override("shadow_offset_x", 4)
		$TaglineLabel.add_theme_constant_override("shadow_offset_y", 4)
		$TaglineLabel.add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.9))
	
	# Background
	var tex = ResourceLoader.load("res://assets/art/environment/title_bg_base.png")
	if tex:
		$Background.texture = tex
	
	# Logo
	var logo_tex = ResourceLoader.load("res://assets/art/ui/metanoia_logo.png")
	if logo_tex:
		$Logo.texture = logo_tex
	
	# Music
	var bgm = ResourceLoader.load("res://assets/audio/music/title_theme.wav")
	if bgm:
		$AudioStreamPlayer.stream = bgm
		$AudioStreamPlayer.play()

func _on_new_game_pressed():
	GameManager.transition_to_scene("res://scenes/menus/CharacterSelection.tscn")

func _on_continue_pressed():
	if SaveManager.has_save():
		var _data = SaveManager.load_game()
		# TODO: Apply loaded data and go to gameplay
		GameManager.transition_to_scene("res://scenes/gameplay/Main.tscn")

func _on_settings_pressed():
	GameManager.push_overlay("res://scenes/menus/SettingsMenu.tscn")

func _on_credits_pressed():
	GameManager.push_overlay("res://scenes/menus/Credits.tscn")

func _on_quit_pressed():
	get_tree().quit()
