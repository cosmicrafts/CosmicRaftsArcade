extends Area2D

@export var Bala:PackedScene
@export var Explosion:PackedScene
@onready var player = get_node("/root/Level1/Player")
const ENEMIGO:PackedScene = preload("res://Enemigo/enemigo.tscn")
#@export var Hub:PackedScene
#var particles = preload("res://Balas/destroy_particles.tscn")

var derecha = false
var izquierda = false
var embestir = false
var activado = true  # para saber si el escudo esta activado
var speed_x = 99
var speed_y = 26
var fase = 0 # 0-4 para activar cada fase y no se salten

var vida = 25  # vida del mini jefe

var puede_disparar = true
var direccion

var velocidad_embestida = 650 # la velocidad de embestida

func _physics_process(delta):
	if !embestir:
		mover(delta)
		
		disparar()
	elif embestir:
		#print("embestir")
		#embestir = true
		embestir_ataque(delta)
		
	#if (vida == 20 || vida == 15 || vida == 10 || vida == 5) && !activado:
	if  ((vida <= 20 && fase == 0) ||
		(vida <= 15 && fase == 1) ||
		(vida <= 10 && fase == 2) ||
		(vida <= 5 && fase == 3)) && !activado:
		#print("vida:",vida)
		embestir = true
		#look_at(player.position)
		$Barrera.get_node("AnimationPlayer").play("activate")
		$Propulsor.visible = true
		activado = true
		
		fase += 1
		
		# apuntar hacia donde se va desplazar el mini jefe (embestida_Ataque)
		direccion = position.direction_to(player.position)
		#direccion = position.direction_to(Global.player.position)
		
		
			
# muchos enemigos embisten ayuda al minijefe
func enemigos_embestida(n:int):
	for i in range(n):
		var enemigo = ENEMIGO.instantiate()
		get_parent().add_child(enemigo)
		#enemigo.global_position = global_position
		enemigo.global_position = Vector2(Global.random(34, 687), position.y)

func mover(delta):
	if position.y < 240:
		position.y += speed_y * delta
	elif activado:
		# Seleccionar si empieza a izquier o derecha
		var opcion = Global.random(0, 2)
		if opcion <= 1:
			derecha = true
		elif  opcion > 1:
			izquierda = true
		#$Barrera.visible = false
		#$Barrera.set_deferred("disabled", true)
		#$Barrera.get_node("CollisionShape2D").disabled = true
		#$Barrera.get_node("Sprite2D").visible = false
		$Barrera.get_node("AnimationPlayer").play("desactivate")
		activado = false
		#print("deracha=true")
		
		match fase:
			1:
				enemigos_embestida(5)
			2:
				enemigos_embestida(10)
			3:
				enemigos_embestida(15)

	if izquierda:
		position.x -= speed_x * delta
		if position.x < 72:
			izquierda = false
			derecha = true
			speed_x = Global.random(99, 500)
	elif derecha:
		position.x += speed_x * delta
		if position.x > 648:
			derecha = false
			izquierda = true
			speed_x = Global.random(99, 500)


func embestir_ataque(delta):
	#position += velocity * delta
	#$Barrera.get_node("CollisionShape2D").disabled = false
	#$Barrera.get_node("Sprite2D").visible = true
	#$Barrera.get_node("AnimationPlayer").play("activate")
	position += direccion * delta * velocidad_embestida
	#print("vida_embestir:",vida)
	#$Propulsor.visible = true

func disparar():
	if puede_disparar:
		var bala = Bala.instantiate()
		#add_child(bala)
		get_parent().add_child(bala)
		bala.global_position = $Bala.global_position
	
		puede_disparar = false
		$BalaTimer.wait_time = Global.random(0.1, 2)

func _on_bala_timer_timeout():
	puede_disparar = true


func _on_area_entered(area):
	if area.is_in_group("Bala"):
		#var particles_instance = particles.instantiate()
		#add_child(particles_instance)
		#particles_instance.global_position = area.position
		
		vida -= 1
		$AnimationPlayer.play("daño")  # daño a color rojo por un instante
		#print("vida_daño:",vida)
		#activado = true
		if vida <= 0:
			muerte_mini_jefe()
			
func muerte_mini_jefe():
	queue_free()
	explosion()
	#fase = 0
	#await get_tree().create_timer(2.0).timeout
	var hub = get_node("/root/Level1/Hub")
	hub.juego_ganado()
	
func explosion():
	var explosion = Explosion.instantiate()
	explosion.global_position = $ExplosionPosicion.global_position
	get_tree().call_group("Nivel", "add_child", explosion)


func _on_visible_on_screen_notifier_2d_screen_exited():
	embestir = false
	position = Vector2(350, -55)
	#$Barrera.get_node("CollisionShape2D").disabled = false
	#$Barrera.get_node("Sprite2D").visible = true
	derecha = false
	izquierda = false
	$Propulsor.visible = false


func _on_body_entered(body):
	body.queue_free()  # muere player
	var hub = get_node("/root/Level1/Hub")
	hub.juego_terminado()
