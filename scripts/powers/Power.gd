extends RigidBody2D

var timer_life=1.5

func _ready():
	pass 

func _process(delta):
	timer_life = timer_life-delta
	if timer_life<=0:
		queue_free()
