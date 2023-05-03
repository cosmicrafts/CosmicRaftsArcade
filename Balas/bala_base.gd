extends Area2D

const PARTICLES: PackedScene = preload("res://Balas/destroy_particles.tscn")

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
		impacto_particulas()
		
		queue_free()
		#borrar()
	
	if area.is_in_group("Jefe"):
		impacto_particulas()
		
		#borrar()
		queue_free()
		
		
	
	if area.is_in_group("Barrera"):
		
		impacto_particulas()
		
		queue_free()
		#var particles_instance = particles.instantiate()
		#add_child(particles_instance)
		#particles_instance.global_position = position
		
		#visible = false
		#$CollisionShape2D.disabled = true
		#await get_tree().create_timer(1.0).timeout
		#pass

func impacto_particulas():
	var main = get_tree().current_scene
	
	var particles = PARTICLES.instantiate()
	main.add_child(particles) 
	#particles.global_position = position
	particles.global_position = $Impacto.global_position



