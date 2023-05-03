extends Node2D


@export var Enemigo:PackedScene
@export var MiniJefe:PackedScene
@export var Asteroide:PackedScene

var player: CharacterBody2D

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK) # color de fondo
	
	$BgMusic.play()
	$EnemyTimer.start()
	randomize()
	
	# instanciar nave del juegador
	player = load(Global.player).instantiate()
	player.global_position = $PosicionPlayer.global_position
	add_child(player)


func _on_hub_game_over():
	$BgMusic.stop()


func _on_enemy_timer_timeout():
	#get_node("EnemyPath/EnemySpawn").set_offset(randi())
	#get_node("EnemyPath/EnemySpawn").set_progress(randi())
	#get_node("EnemyPath/EnemySpawn").set_progress(Global.random(0, 705))
	$EnemigoSpawn.position = Vector2(Global.random(34, 687), position.y)
	var enemigo = Enemigo.instantiate()
	add_child(enemigo)
	#enemigo.position = get_node("EnemyPath/EnemySpawn").position
	enemigo.position = $EnemigoSpawn.position
	$EnemyTimer.wait_time = Global.random(0.2, 2.5)  # rango de tiempo de aparicion del enemigo
	$EnemyTimer.start()
	
	var asteroide = Asteroide.instantiate()
	add_child(asteroide)
	asteroide.position = $EnemigoSpawn.position

# depues de 60 segundo entrara el minijefe y dejara de spamear los enemigos
func _on_timer_inicio_mini_jefe_timeout():
	$EnemyTimer.stop()
	var mini_jefe = MiniJefe.instantiate()
	add_child(mini_jefe)
	mini_jefe.position = $MiniJefe.position
