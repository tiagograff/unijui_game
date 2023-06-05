extends ParallaxBackground

@onready var parallax_layer: ParallaxLayer = get_node("ParallaxLayer")
@onready var background_layer: TextureRect = get_node("ParallaxLayer/BackgroundLayer")

@export var direction: Vector2
@export var move_speed: float

func _physics_process(delta: float) -> void:
	parallax_layer.motion_offset += direction * delta * move_speed
