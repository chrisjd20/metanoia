extends Node

# AudioManager handles music/SFX bus management and crossfading between tracks.
func _ready():
    process_mode = Node.PROCESS_MODE_ALWAYS
