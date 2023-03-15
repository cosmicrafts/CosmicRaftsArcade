extends Area2D


var velocidad = 40


func _ready():
	velocidad = Global.random(40, 750)
	

func _physics_process(delta):
	position.y += velocidad * delta


func _on_body_entered(body):
	if body.is_in_group("Player"):
		if Global.cañon < 3:
			Global.cañon += 1
			#print("entro power")
		
		$Sonido.play()
		$Sprite2D.visible = false


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_sonido_finished():
	queue_free()
