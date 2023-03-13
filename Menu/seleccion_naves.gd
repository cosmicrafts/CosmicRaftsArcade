extends Node2D

var player1: String = "res://Player/player.tscn"
var player2: String = "res://Player/player2.tscn"

func _on_player_pressed():
	Global.player = player1
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")

func _on_player_2_pressed():
	Global.player = player2
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")
