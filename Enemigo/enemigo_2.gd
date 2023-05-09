extends Area2D
@export var Explosion:PackedScene
#@export var PowerUp:PackedScene
#@export var CañonPowerUp:PackedScene
@onready var window_size: Vector2  = get_viewport_rect().size
var speed: Vector2
var dir := -1
@export var health: int = 3

func _ready():
	#speed = Global.random(99, 720)
	speed = Vector2(Global.random(10, 30), Global.random(30, 70))
	#dir = Global.random(-2, 2)
	#dir = Global.random(-4, 4)
	var opcion = Global.random(0, 2)
	if opcion <= 1:
		dir = -2
	elif  opcion > 1:
		dir = 2

func _physics_process(delta):
	position.x += speed.x * delta * dir
	position.y += speed.y * delta 
	
	#rotation += 0.01
	
	if position.x > window_size.x  or position.x < 0:
		dir *= -1


func death_enemy():
	queue_free()
	explosion_ctrl()

func explosion_ctrl():
	var explosion = Explosion.instantiate()
	explosion.global_position = global_position
	get_tree().call_group("Nivel", "add_child", explosion)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.queue_free()
		var hub = get_node("/root/Level1/Hub")
		hub.juego_terminado()


func _on_area_entered(area):
	if area.is_in_group("Bala"):
		health -= 1
		$AnimationPlayer.play("daño") # cambiar de colo cuando daño por un instante
		if health <= 0:
			death_enemy()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
