extends VBoxContainer


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Menu/play.tscn")
