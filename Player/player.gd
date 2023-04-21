extends CharacterBody2D

var selected = false
var Bala = preload("res://Balas/bala_skorn.tscn")
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
	#print("position:", position)
	# limitar  movimiento  del personaje
	#position.x = clamp(position.x, 0, screensize.x)
	#position.y = clamp(position.y, 0, screensize.y)
	if global_position.y > get_global_mouse_position().y + 0.25:  # le sumamos 0.25 ala cordenada "y" para ser ma exacto al acivar
		$Propulsor.visible = true
	else :
		$Propulsor.visible = false


func _on_input_event(viewport, event, shape_idx):
	if !Input.is_action_pressed("click"):
		selected = false
	else:
		selected = true


func disparar():
	$BalaTimer.wait_time = Global.bala_timer
	if puede_disparar:
		
		match Global.cañon:
			1:
				var bala = Bala.instantiate()
				get_parent().add_child(bala)
				bala.global_position = $BalaPosicion1.global_position
			2:
				var bala2 = Bala.instantiate()
				var bala3 = Bala.instantiate()
				get_parent().add_child(bala2)
				get_parent().add_child(bala3)
				bala2.global_position = $BalaPosicion2.global_position
				bala3.global_position = $BalaPosicion3.global_position
			3:
				var bala1 = Bala.instantiate()
				var bala2 = Bala.instantiate()
				var bala3 = Bala.instantiate()
				get_parent().add_child(bala1)
				get_parent().add_child(bala2)
				get_parent().add_child(bala3)
				bala1.global_position = $BalaPosicion1.global_position
				bala2.global_position = $BalaPosicion2.global_position
				bala3.global_position = $BalaPosicion3.global_position
		
	
		puede_disparar = false


func _on_bala_timer_timeout():
	puede_disparar = true
	
	#$BalaTimer.wait_time = Global.bala_timer
