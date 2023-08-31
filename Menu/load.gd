extends Control


var niveles: Dictionary = {
	1: "res://Levels/level_1.tscn",
	2: "res://Levels/level_2.tscn"
}


func _on_start_pressed():
	get_tree().change_scene_to_file(niveles[Global.nivel])  # en la variable global tenemos guardado el progreso de los niveles pasados


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Menu/play.tscn")
