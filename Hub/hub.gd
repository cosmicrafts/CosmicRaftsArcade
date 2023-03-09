extends CanvasLayer

signal game_over  


func _ready():
	Global.score = 0

func _physics_process(delta):
	$ScoreContainer/HBoxContainer/Score.text = str(Global.score)

func juego_terminado():
	emit_signal("game_over")
	$GameOverContainer.visible = true
	$BgMusic.play()
	
	# pausamos el juego al morir, 
	# Activar en la escena hub -> process -> always (para que no se detenga esa escena)
	#get_tree().paused = true


func _on_menu_pressed():
	#get_tree().call_deferred("change_scene","res://Menu/menu.tscn")
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
	#get_tree().paused = false # desactivamos la pausa del juego


func _on_restart_pressed():
	get_tree().call_deferred("reload_current_scene")
	#get_tree().paused = false


func _on_player_tree_exiting():
	juego_terminado()

func juego_ganado():
	$WonContainer.visible = true
