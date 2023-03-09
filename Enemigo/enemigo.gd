extends Area2D

@export var Explosion:PackedScene
@export var PowerUp:PackedScene
var speed

func _ready():
	speed = Global.random(99, 620)


func _physics_process(delta):
	position.y += speed * delta

func death_enemy():
	queue_free()
	explosion_ctrl()


func explosion_ctrl():
	var explosion = Explosion.instantiate()
	explosion.global_position = $ExplosionSpawn.global_position
	get_tree().call_group("Nivel", "add_child", explosion)

func _on_area_entered(area):
	if area.is_in_group("Bala"):
		death_enemy()
		Global.score += 1
		queue_free()
		#print("random:", Global.random(0, 5))
		# probabilidad que salga un powerup al morir enemigo
		if Global.random(0, 11) < 1:
			power_up()


func _on_body_entered(body):
	if body.is_in_group("Player"):
		death_enemy() 
		body.queue_free()


func power_up():
	var power_up = PowerUp.instantiate()
	#add_child(power_up)
	#get_parent().add_child(power_up)
	get_parent().call_deferred("add_child", power_up)
	power_up.global_position = global_position

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
