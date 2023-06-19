extends Area2D

@export var mana: int = 0
@export var mana_scenes: Array = []
@export var sprite_copia: Sprite2D
@onready var interface = get_tree().root.get_node("/root/Interface")
@onready var Sprite: Sprite2D = get_node("Sprite")

func _ready() -> void:
	mana_scenes.append(load("res://images/mana/mana0.png"))
	mana_scenes.append(load("res://images/mana/mana1.png"))
	mana_scenes.append(load("res://images/mana/mana2.png"))
	mana_scenes.append(load("res://images/mana/mana3.png"))
	mana_scenes.append(load("res://images/mana/mana4.png"))
	mana_scenes.append(load("res://images/mana/mana5.png"))
	mana_scenes.append(load("res://images/mana/mana6.png"))
	
	var sprite_original = interface.get_node("Mana") as Sprite2D
	sprite_copia = sprite_original.duplicate()
	sprite_copia.texture = mana_scenes[mana]
	interface.add_child(sprite_copia)

func on_body_entered(body) -> void:
	if body.is_in_group("character"):
		mana += 1
		if mana >= mana_scenes.size():
			mana = 0 
		
		var sprite_copia = interface.get_node("Mana") 
		queue_free()
		$Collision.disabled
		if sprite_copia != null:
			sprite_copia.texture = mana_scenes[mana]
			queue_free()
			$Collision.disabled
