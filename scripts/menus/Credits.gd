extends Control

var scroll_tween: Tween

const CREDITS_TEXT = """[center][font_size=32][color=#d9b34a]METANOIA[/color][/font_size]

[font_size=18][color=#ccc5a8]"Put on the whole armor of God."
— Ephesians 6:11[/color][/font_size]

[font_size=14][color=#999]─────────────────[/color][/font_size]

[font_size=22][color=#d9b34a]Design & Development[/color][/font_size]
[font_size=18][color=#e6dcc8]Chris[/color][/font_size]

[font_size=22][color=#d9b34a]Game Engine[/color][/font_size]
[font_size=18][color=#e6dcc8]Godot Engine 4.6[/color][/font_size]

[font_size=22][color=#d9b34a]Art & Assets[/color][/font_size]
[font_size=18][color=#e6dcc8]Placeholder Art — Final Art TBD[/color][/font_size]

[font_size=22][color=#d9b34a]Music & Audio[/color][/font_size]
[font_size=18][color=#e6dcc8]Placeholder Audio — Final Audio TBD[/color][/font_size]

[font_size=22][color=#d9b34a]Fonts[/color][/font_size]
[font_size=18][color=#e6dcc8]Cinzel by Natanael Gama
Cinzel Decorative by Natanael Gama
EB Garamond by Georg Duffner[/color][/font_size]

[font_size=14][color=#999]─────────────────[/color][/font_size]

[font_size=22][color=#d9b34a]Special Thanks[/color][/font_size]
[font_size=18][color=#e6dcc8]To God, for everything.[/color][/font_size]

[font_size=14][color=#999]─────────────────[/color][/font_size]

[font_size=16][color=#8a7f60]© 2026 Metanoia. All rights reserved.[/color][/font_size]
[/center]"""

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	$CreditsLabel.text = CREDITS_TEXT
	
	# Font for back button
	var body_font = ResourceLoader.load("res://assets/fonts/Cinzel.ttf")
	if body_font:
		$BackButton.add_theme_font_override("font", body_font)
		$BackButton.add_theme_font_size_override("font_size", 22)
		$BackButton.add_theme_color_override("font_color", Color(0.9, 0.85, 0.7))
		$BackButton.add_theme_color_override("font_hover_color", Color(1.0, 0.9, 0.5))
	
	$BackButton.pressed.connect(_on_back_pressed)
	
	# Start scrolling credits upward
	_start_scroll()

func _start_scroll():
	# Position credits below the screen, scroll upward
	var start_y = 400.0
	var end_y = -1200.0
	$CreditsLabel.position.y = start_y
	
	scroll_tween = create_tween()
	scroll_tween.tween_property($CreditsLabel, "position:y", end_y, 20.0).set_ease(Tween.EASE_IN_OUT)

func _on_back_pressed():
	if scroll_tween:
		scroll_tween.kill()
	GameManager.pop_overlay()
