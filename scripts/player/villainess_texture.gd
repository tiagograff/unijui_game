extends Sprite2D

@export var animation: AnimationPlayer = null
@export var villainess: CharacterBody2D = null

var on_action: bool = false

func animate(velocity: Vector2) -> void:
	change_orientation_based_on_direction(velocity.x)
	if on_action == true:
		return
	if velocity.y != 0:
		vertical_move_behavior(velocity.y)
		return
	horizontal_move_behavior(velocity.x)
	
func change_orientation_based_on_direction(direction: float)-> void:
	if direction > 0:
		flip_h = false
	if direction < 0:
		flip_h = true

func action_behavior(action: String):
	animation.play(action)
	on_action = true

func vertical_move_behavior(direction: float)-> void:
	if direction > 0:
		animation.play("fall")
	if direction < 0:
		animation.play("jump")

func horizontal_move_behavior(direction: float) -> void:
	if direction != 0: 
		animation.play("run")
		
		return
	animation.play("idle")

func on_animation_player_finished(_anim_name: String) -> void:
	on_action = false
	if _anim_name == "hit":
		villainess.on_knockback = false
	if _anim_name == "dead":
		hide()
		transition_screen.fade_in()
