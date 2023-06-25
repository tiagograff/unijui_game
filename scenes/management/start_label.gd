extends Label

func _process(delta):
	if visible==true:
		if Input.is_action_just_pressed("SPACE"):
			get_tree().paused=false
			get_tree().change_scene_to_file('res://scenes/management/level_0.tscn')
			transition_screen.next_scene()

