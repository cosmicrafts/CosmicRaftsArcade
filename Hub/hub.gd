extends CanvasLayer

signal game_over  


func _ready():
	Global.score = 0

func _physics_process(delta):
	$ScoreContainer/HBoxContainer/Score.text = str(Global.score)

func juego_terminado():
	emit_signal("game_over")
	#$GameOverContainer.visible = true
	
	# resetear la velocidad de disparo
	Global.bala_timer = 1.0
	# resetear numero de cañones de la nave
	Global.cañon = 1
	
	get_tree().change_scene_to_file("res://Menu/game_over.tscn")
	# pausamos el juego al morir, 
	# Activar en la escena hub -> process -> always (para que no se detenga esa escena)
	#get_tree().paused = true


#func _on_player_tree_exiting():
#	juego_terminado()

func juego_ganado():
	#$WonContainer.visible = true
	await get_tree().create_timer(1.5).timeout  # experara animacion de explosion del jefe
	# resetear la velocidad de disparo
	Global.bala_timer = 1.0
	# resetear numero de cañones de la nave
	Global.cañon = 1
	get_tree().change_scene_to_file("res://Menu/won.tscn")
