extends CharacterBody2D

var selected = false
var Bala = preload("res://Balas/bala_base.tscn")
var speed = 90

var puede_disparar = true

#@onready var screensize = get_viewport_rect().size # Tamaño  de nuestra ventana

func _physics_process(delta):
	#global_position.y -= speed * delta # movimiento base
	
	if selected:
		move_player(delta)
	#await get_tree().create_timer(2.0).timeout
	disparar()

func move_player(delta):
	global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	#print("mouse_position:", get_global_mouse_position())
	#print("global_position:",global_position)
	# limitar  movimiento  del personaje
	#position.x = clamp(position.x, 0, screensize.x)
	#position.y = clamp(position.y, 0, screensize.y)


func _on_input_event(viewport, event, shape_idx):
	if !Input.is_action_pressed("click"):
		selected = false
	else:
		selected = true


func disparar():
	if puede_disparar:
		var bala = Bala.instantiate()
		#var bala2 = Bala.instantiate()
		#add_child(bala)
		get_parent().add_child(bala)
		#get_parent().add_child(bala2)
		bala.global_position = $BalaPosicion.global_position
		#bala2.global_position = $BalaPosicion2.global_position
		
	
		puede_disparar = false


func _on_bala_timer_timeout():
	puede_disparar = true
	
	$BalaTimer.wait_time = Global.bala_timer


func _on_tree_exiting():
	var hub = get_node("/root/Level1/Hub")
	hub.juego_terminado()
