extends CanvasLayer
@onready var interface = get_tree().root.get_node("/root/Interface")

@onready var parallax_layer: ParallaxLayer = get_node("Background/ParallaxLayer")
@onready var background_layer: TextureRect = get_node("Background/ParallaxLayer/TextureRect")

@export var direction: Vector2
@export var move_speed: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	parallax_layer.motion_offset += direction * delta * move_speed
