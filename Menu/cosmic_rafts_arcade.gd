extends Control


func _ready():
	#Global.player = "res://Player/player.tscn"
	#Global.nave = 0
	#Global.nivel = 1
	Save.load_data() # cargamos el progreso del juego, si es nuevo se crea
	Global.nave = Save.game_data.ship
	Global.nivel = Save.game_data.level
	Global.vida = Save.game_data.life

func _on_timer_timeout():
	get_node("AnimationPlayer").play("Intro")


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Intro":
			get_tree().call_deferred("change_scene_to_file","res://Menu/play.tscn")
