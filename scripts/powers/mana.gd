extends Area2D

@export var mana_scenes: Array = []
@export var sprite_copia: Sprite2D
@onready var interface = get_tree().root.get_node("/root/Interface")
@onready var Sprite: Sprite2D = get_node("Sprite")
var frasco = null

func _ready() -> void:
	frasco =  get_node("/root/Interface")
	mana_scenes.append(load("res://images/mana/mana0.png"))
	mana_scenes.append(load("res://images/mana/mana1.png"))
	mana_scenes.append(load("res://images/mana/mana2.png"))
	mana_scenes.append(load("res://images/mana/mana3.png"))
	mana_scenes.append(load("res://images/mana/mana4.png"))
	mana_scenes.append(load("res://images/mana/mana5.png"))
	mana_scenes.append(load("res://images/mana/mana6.png"))
	
	var sprite_original = interface.get_node("Mana") as Sprite2D
	sprite_copia = sprite_original.duplicate()
	sprite_copia.texture = mana_scenes[frasco.mana]
	interface.add_child(sprite_copia)

func on_body_entered(body) -> void:
	if body.is_in_group("character"):
		frasco.mana += 1 
		
		for i in range(1,7):
			var m = get_node("/root/Interface/Mana"+str(i))
			if i <= frasco.mana:
				m.visible=true
			else:
				m.visible=false
		
		var sprite_copia = interface.get_node("Mana") 
		queue_free()
		$Collision.disabled
		if sprite_copia != null:
			queue_free()
			$Collision.disabled
