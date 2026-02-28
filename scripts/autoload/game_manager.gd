extends Node

# GameManager handles game state, scene transitions, and pause/unpause.
func _ready():
    process_mode = Node.PROCESS_MODE_ALWAYS
