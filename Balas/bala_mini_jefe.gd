extends Area2D

#@onready var player = get_node("/root/Level1/Player")
@onready var player = get_node("/root/Level1/" + Global.NOMBRE_NAVE[Global.nave])
var speed
#@onready var direccion = position.direction_to(player.position)
var direccion
var activo:bool = true  # para que direccion no se modifique

func _ready():
	speed = Global.random(99, 520)
	#direccion = position.direction_to(player.position)
	#direccion = global_position.direction_to(player.global_position)

func _physics_process(delta):
	#global_position.y += speed * delta
	if activo:
		direccion = position.direction_to(player.position)
		activo = false
	position += direccion * delta * speed
	#global_position += direccion * delta * speed


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.queue_free()
		queue_free()
		var hub = get_node("/root/Level1/Hub")
		hub.juego_terminado()


func _on_area_entered(area):
	if area.is_in_group("Barrera"):
		queue_free()
