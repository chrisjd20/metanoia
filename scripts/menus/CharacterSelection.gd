extends Control

var selected_gender: String = "male"
var male_panel: PanelContainer
var female_panel: PanelContainer

const SELECTED_COLOR := Color(0.85, 0.7, 0.3, 0.35)
const UNSELECTED_COLOR := Color(0.15, 0.12, 0.2, 0.6)
const BORDER_SELECTED := Color(0.85, 0.7, 0.3, 0.9)
const BORDER_UNSELECTED := Color(0.4, 0.35, 0.3, 0.3)

func _ready():
	male_panel = $CenterContainer/VBoxContainer/HBoxContainer/MalePanel
	female_panel = $CenterContainer/VBoxContainer/HBoxContainer/FemalePanel
	
	# Wire buttons
	$CenterContainer/VBoxContainer/ButtonBox/BackButton.pressed.connect(_on_back_pressed)
	$CenterContainer/VBoxContainer/ButtonBox/ConfirmButton.pressed.connect(_on_confirm_pressed)
	
	# Wire panel clicks
	male_panel.gui_input.connect(_on_male_panel_input)
	female_panel.gui_input.connect(_on_female_panel_input)
	
	# Load assets
	var bg = ResourceLoader.load("res://assets/art/environment/character_select_bg.png")
	if bg:
		$Background.texture = bg
	
	var male_tex = ResourceLoader.load("res://assets/art/characters/pilgrim_male_silhouette.png")
	if male_tex:
		$CenterContainer/VBoxContainer/HBoxContainer/MalePanel/MaleVBox/MaleSprite.texture = male_tex
	
	var female_tex = ResourceLoader.load("res://assets/art/characters/pilgrim_female_silhouette.png")
	if female_tex:
		$CenterContainer/VBoxContainer/HBoxContainer/FemalePanel/FemaleVBox/FemaleSprite.texture = female_tex
	
	# Fonts
	var header_font = ResourceLoader.load("res://assets/fonts/CinzelDecorative-Bold.ttf")
	var body_font = ResourceLoader.load("res://assets/fonts/Cinzel.ttf")
	if header_font:
		$CenterContainer/VBoxContainer/HeaderLabel.add_theme_font_override("font", header_font)
		$CenterContainer/VBoxContainer/HeaderLabel.add_theme_font_size_override("font_size", 36)
		$CenterContainer/VBoxContainer/HeaderLabel.add_theme_color_override("font_color", Color(0.85, 0.7, 0.3))
	if body_font:
		for lbl_path in ["MalePanel/MaleVBox/MaleLabel", "FemalePanel/FemaleVBox/FemaleLabel"]:
			var lbl = $CenterContainer/VBoxContainer/HBoxContainer.get_node(lbl_path)
			lbl.add_theme_font_override("font", body_font)
			lbl.add_theme_font_size_override("font_size", 20)
			lbl.add_theme_color_override("font_color", Color(0.9, 0.85, 0.7))
		for btn in [$CenterContainer/VBoxContainer/ButtonBox/BackButton, $CenterContainer/VBoxContainer/ButtonBox/ConfirmButton]:
			btn.add_theme_font_override("font", body_font)
			btn.add_theme_font_size_override("font_size", 24)
			btn.add_theme_color_override("font_color", Color(0.9, 0.85, 0.7))
			btn.add_theme_color_override("font_hover_color", Color(1.0, 0.9, 0.5))
	
	# Initial selection
	_update_selection()

func _on_male_panel_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		selected_gender = "male"
		_update_selection()

func _on_female_panel_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		selected_gender = "female"
		_update_selection()

func _update_selection():
	_style_panel(male_panel, selected_gender == "male")
	_style_panel(female_panel, selected_gender == "female")

func _style_panel(panel: PanelContainer, is_selected: bool):
	var style = StyleBoxFlat.new()
	style.bg_color = SELECTED_COLOR if is_selected else UNSELECTED_COLOR
	style.border_color = BORDER_SELECTED if is_selected else BORDER_UNSELECTED
	style.set_border_width_all(3 if is_selected else 1)
	style.set_corner_radius_all(8)
	panel.add_theme_stylebox_override("panel", style)

func _on_confirm_pressed():
	GameManager.selected_gender = selected_gender
	SaveManager.selected_gender = selected_gender
	GameManager.transition_to_scene("res://scenes/gameplay/Main.tscn")

func _on_back_pressed():
	GameManager.transition_to_scene("res://scenes/menus/TitleScreen.tscn")
