extends CharacterBody2D

@onready var sprite: Sprite2D = get_node("Texture")

var is_dead: bool = false
var jump_count: int = 0
var is_on_double_jump: bool = false
var on_knockback = false
var max_health: float = 0.0
var knockback_direction: Vector2

@export var move_speed: float = 96.00
@export var jump_speed: float = -256.00
@export var gravity_speed: float = 512.00
@export var health: float = 25.0
@export var damage: int

func _ready() -> void:
	max_health = health

func _physics_process(delta) -> void:
	if is_dead == true:
		return
	if on_knockback == true:
		knockback_move()
		return
	move()
	velocity.y += delta * gravity_speed
	var _move := move_and_slide()
	jump()
	sprite.animate(velocity)
	
	if $Ray_Jump.is_colliding():
		var obj = $Ray_Jump.get_collider()
		if obj.is_in_group("enemy"):
			obj.damage()
			velocity.y = jump_speed

func knockback_move():
	velocity = knockback_direction * move_speed * 2
	var _move := move_and_slide()
	sprite.animate(velocity)

func move() -> void:
	var direction: float = get_direction()
	velocity.x = direction * move_speed
	if(direction != 0 && $Footsteps_timer.time_left <= 0 && is_on_floor()):
		$Footsteps.pitch_scale = 1
		$Footsteps.play()
		$Footsteps_timer.start(0.3)

func get_direction() -> float:
	return Input.get_axis("walk_left","walk_right")

func jump() -> void:
	if is_on_floor():
		jump_count = 0
		is_on_double_jump = false
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		velocity.y = jump_speed 
		$Jump.play()
		jump_count += 1
	if jump_count == 2 and not is_on_double_jump:
		sprite.action_behavior("double_jump")
		$Jump.play()
		is_on_double_jump = true

func update_health(_target_position: Vector2, value: int, type: String)-> void:
	if is_dead == true:
		return
	if type == "decrease":
		knockback_direction = (global_position - _target_position).normalized()
		sprite.action_behavior("hit")
		$Hit.play()
		on_knockback = true
		health = clamp(health - value, 0, max_health)
		
		if health == 0:
			character_died()
		return
	if type == "increase":
		health = clamp(health + value,0,max_health)


		
func blink_restart_label():
	while(true):
		get_node("../CanvasLayer2/Restart").visible = true
		await get_tree().create_timer(0.5).timeout
		get_node("../CanvasLayer2/Restart").visible = false
		await get_tree().create_timer(0.5).timeout
		
func character_died():
	is_dead = true
	$Hit.play()
	sprite.action_behavior("dead")
	await get_tree().create_timer(0.5).timeout
	$Dead.play()
	get_node("../CanvasLayer2/Game_over").visible = true
	transition_screen.fade_in()
	blink_restart_label()
	
func _on_hitbox_area_entered(area):
	if area.is_in_group("buraco"):
		character_died()
	if area.is_in_group("portal"):
		get_tree().change_scene_to_file('res://scenes/management/level_1.tscn')



func on_hitbox_body_entered(body):
	if body.is_in_group("enemy"):
		self.update_health(body.global_position, 10, "decrease")
