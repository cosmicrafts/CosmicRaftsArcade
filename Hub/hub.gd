extends CanvasLayer

signal game_over  


func _ready():
	Global.score = 0

func _physics_process(delta):
	$ScoreContainer/HBoxContainer/Score.text = str(Global.score)

func juego_terminado():
	emit_signal("game_over")
	#$GameOverContainer.visible = true
	
	get_tree().change_scene_to_file("res://Menu/game_over.tscn")
	# pausamos el juego al morir, 
	# Activar en la escena hub -> process -> always (para que no se detenga esa escena)
	#get_tree().paused = true


#func _on_player_tree_exiting():
#	juego_terminado()

func juego_ganado():
	#$WonContainer.visible = true
	get_tree().change_scene_to_file("res://Menu/won.tscn")
