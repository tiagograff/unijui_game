extends CharacterBody2D

const move_speed: float = 50.0
const jump_velocity: float = -400.0 
var direction: float = 1.0     
var state: String = "active"
var timmer_out: float = 2.0    
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta) -> void:
	if state == "inactive":
		position.y += delta*300.00
		rotation_degrees += delta*360
		timmer_out -= delta
		if timmer_out <= 0:
			queue_free()
		
	if state == "active":
		if $Ray_Right.is_colliding():
			direction = -1 
		if $Ray_Left.is_colliding():
			direction = 1
		if $Ray_Down_Right.is_colliding() == false and $Ray_Down_Left.is_colliding() == true:
			direction = -1
		if $Ray_Down_Right.is_colliding() == true and $Ray_Down_Left.is_colliding() == false:
			direction = 1
		
		if not is_on_floor():
			velocity.y = gravity * delta
		
		if direction:
			velocity.x = direction * move_speed
		else:
			velocity.x = move_toward(velocity.x,0,move_speed)
		
		move_and_slide()
		
func damage() -> void:
	state = "inactive"
	$Collision.disabled = true
	$Animated.play("dead")


func on_hit_box_body_entered(_body):
	pass
