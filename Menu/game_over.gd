extends Control


func _ready():
	$BgMusic.play()



func _on_continue_pressed():
	get_tree().change_scene_to_file("res://Menu/play.tscn")
