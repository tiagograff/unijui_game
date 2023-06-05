extends Node2D

@export var scene_path: String = ""

func _ready() -> void:
	transition_screen.target_path = scene_path
	
	transition_screen.connect(
		"start_level", Callable(self, "start_level")
	)
	
func start_level() -> void:
	pass
