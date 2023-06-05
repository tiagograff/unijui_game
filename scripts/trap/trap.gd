extends StaticBody2D

@export var damage: int

func on_detection_area_body_entered(body) -> void:
	if body.is_in_group("character"):
		body.update_health(global_position, damage, "decrease")
