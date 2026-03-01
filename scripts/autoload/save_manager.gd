extends Node

const SETTINGS_PATH = "user://settings.cfg"
const SAVE_PATH = "user://savegame.json"

# Settings
var master_volume: float = 80.0
var music_volume: float = 80.0
var sfx_volume: float = 80.0
var fullscreen: bool = false
var screen_shake_intensity: float = 1.0

# Game state
var selected_gender: String = "male"

func _ready():
	load_settings()

# --- Settings ---
func save_settings() -> void:
	var config = ConfigFile.new()
	config.set_value("audio", "master_volume", master_volume)
	config.set_value("audio", "music_volume", music_volume)
	config.set_value("audio", "sfx_volume", sfx_volume)
	config.set_value("display", "fullscreen", fullscreen)
	config.set_value("display", "screen_shake_intensity", screen_shake_intensity)
	config.save(SETTINGS_PATH)

func load_settings() -> void:
	var config = ConfigFile.new()
	if config.load(SETTINGS_PATH) != OK:
		return
	master_volume = config.get_value("audio", "master_volume", 80.0)
	music_volume = config.get_value("audio", "music_volume", 80.0)
	sfx_volume = config.get_value("audio", "sfx_volume", 80.0)
	fullscreen = config.get_value("display", "fullscreen", false)
	screen_shake_intensity = config.get_value("display", "screen_shake_intensity", 1.0)

# --- Game Save ---
func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func save_game(data: Dictionary) -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data, "\t"))
		file.close()

func load_game() -> Dictionary:
	if not has_save():
		return {}
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return {}
	var json = JSON.new()
	var result = json.parse(file.get_as_text())
	file.close()
	if result == OK:
		return json.data
	return {}
