extends Area2D

var velocidad = 40


func _ready():
	velocidad = Global.random(40, 650)
	#monitoring = true
	#$Sonido.play()

func _physics_process(delta):
	position.y += velocidad * delta


func _on_body_entered(body):
	if body.is_in_group("Player"):
		#print("bala_timer:", Global.bala_timer)
		#$Sonido.play()
		if Global.bala_timer > 0.21:
			Global.bala_timer -= 0.2
			#print("entro power")
		
		$Sonido.play()
		#self.monitoring = false
		$Sprite2D.visible = false
		#$CollisionShape2D.disabled = true
		#get_node("CollisionShape2D").disabled = true
		#monitorable = false
		
		#set_monitoring(false)
		

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()




func _on_sonido_finished():
	queue_free()
