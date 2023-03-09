extends Area2D

const SPEED = 550


func _ready():
	$SoundShoot.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.y -= SPEED * delta


# destruir(liberar) bala fuera de pantalla
func _on_visible_on_screen_notifier_2d_screen_exited():  # Si sale fuera de la pantalla se libera la bala(borrar)
	queue_free()


func _on_area_entered(area):
	if area.is_in_group("Enemigo"):
		#area.queue_free()
		queue_free()
	
	if area.is_in_group("Jefe"):
		queue_free()
	
	if area.is_in_group("Barrera"):
		queue_free()
