extends Area2D

@export var Bala:PackedScene
@export var Explosion:PackedScene
@onready var player = get_node("/root/Level1/Player")
#@export var Hub:PackedScene

var derecha = false
var izquierda = false
var embestir = false
var speed_x = 99
var speed_y = 26

var vida = 20  # vida del mini jefe

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
		
	if vida == 15 || vida == 10 || vida == 5:
		embestir = true
		#look_at(player.position)
		
		# apuntar hacia donde se va desplazar el mini jefe (embestida_Ataque)
		direccion = position.direction_to(player.position)
		#direccion = position.direction_to(Global.player.position)


func mover(delta):
	if position.y < 240:
		position.y += speed_y * delta
	else:
		derecha = true
		#$Barrera.visible = false
		#$Barrera.set_deferred("disabled", true)
		$Barrera.get_node("CollisionShape2D").disabled = true
		$Barrera.get_node("Sprite2D").visible = false

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
	$Barrera.get_node("CollisionShape2D").disabled = false
	$Barrera.get_node("Sprite2D").visible = true
	position += direccion * delta * velocidad_embestida

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
		vida -= 1
		#print("vida:",vida)
		if vida <= 0:
			muerte_mini_jefe()
			
func muerte_mini_jefe():
	queue_free()
	explosion()
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


func _on_body_entered(body):
	body.queue_free()  # muere player
	var hub = get_node("/root/Level1/Hub")
	hub.juego_terminado()
