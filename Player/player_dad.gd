extends CharacterBody2D

var players: Dictionary = {
	0: "res://Player/skorn.tscn",  # 0
	1: "res://Player/aniglen.tscn" # 1
}

func _ready():
	var player = load(players[Global.nave])
	var instance = player.instantiate()
	add_child(instance)
	
	
