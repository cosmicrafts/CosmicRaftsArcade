extends Area2D


var speed

func _ready():
	speed = Global.random(99, 520)

func _physics_process(delta):
	global_position.y += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.queue_free()
		queue_free()
