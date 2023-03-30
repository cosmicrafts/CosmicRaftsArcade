extends Control

var naves: Dictionary = {
	0: "res://Assets/Player/Skorn_Ship.png",
	1: "res://Assets/Player/aniglen_ship.png"
}

var avatar_naves: Dictionary = {
	0: "res://Assets/Player/Skorn_transparency.png",
	1: "res://Assets/Player/aniglen_transparente.png"
}

func _ready():
	$Nave.texture_normal = load(naves[Global.nave])
	$Nave.scale = Vector2(0.35, 0.35)
	#$Nave.scale.y = 0.6
	
	$AvatarNave.texture = load(avatar_naves[Global.nave])

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")


func _on_hero_pressed():
	get_tree().change_scene_to_file("res://Menu/heroe_seleccion.tscn")


func _on_nave_pressed():
	get_tree().change_scene_to_file("res://Menu/heroe_seleccion.tscn")
