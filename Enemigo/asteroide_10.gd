extends Area2D

const EXPLOSION: PackedScene = preload("res://Enemigo/explosion.tscn")
const ASTEROIDE_PEQUEÑO: PackedScene = preload("res://Enemigo/asteroide_10_pequeño.tscn")
const ASTEROIDE1: CompressedTexture2D = preload("res://Assets/enemigos/Asteroid10.png")
const ASTEROIDE2: CompressedTexture2D = preload("res://Assets/enemigos/AsteroidSpecial04.png")
const ASTEROIDE3: CompressedTexture2D = preload("res://Assets/enemigos/AsteroidSpecial03.png")

@onready var window_size: Vector2  = get_viewport_rect().size

@export var speed: Vector2 = Vector2(10,40)
@export var health: int = 3

var dir := -1
@onready var seleccion_asteroide = Global.random(0, 2)

func _ready():
	dir = Global.random(-2, 2)
	#dir = Global.random(-4, 4)
	if seleccion_asteroide < 1:
		if seleccion_asteroide > 0.5:
			$Sprite2D.texture = ASTEROIDE1
		elif seleccion_asteroide > 0:
			$Sprite2D.texture = ASTEROIDE3
	elif seleccion_asteroide > 1:
		$Sprite2D.texture = ASTEROIDE2
	#print("dir:", dir)

func _physics_process(delta):
	position.x += speed.x * delta * dir
	position.y += speed.y * delta 
	
	rotation += 0.005
	
	if position.x > window_size.x  or position.x < 0:
		dir *= -1


func kill():
	var main = get_tree().current_scene
	
	var explosion_fx = EXPLOSION.instantiate()
	main.add_child(explosion_fx) 
	explosion_fx.global_position = global_position
	
	var asteroid = ASTEROIDE_PEQUEÑO.instantiate()
	main.call_deferred("add_child", asteroid )
	asteroid.global_position = global_position
	
	var asteroid_2 = ASTEROIDE_PEQUEÑO.instantiate()
	main.call_deferred("add_child", asteroid_2 )
	asteroid_2.global_position = global_position
	asteroid_2.dir = 1
	
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


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
			kill()
