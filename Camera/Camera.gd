extends Camera2D


var speed = 90

# Called when the node enters the scene tree for the first time.



func _physics_process(delta):
	global_position.y -= speed * delta
	
