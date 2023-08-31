extends Control


var players: Dictionary = {
	0: "res://Player/skorn.tscn",  # 0
	1: "res://Player/aniglen.tscn" # 1
}

var naves: Dictionary = {
	0: "res://Assets/Player/Skorn_Ship_256.png",
	1: "res://Assets/Player/aniglen_ship.png"
}

var avatar_naves: Dictionary = {
	0: "res://Assets/Player/Skorn_transparency.png",
	1: "res://Assets/Player/aniglen_transparente.png"
}



const TITULO_NAVE: Dictionary = {
	0: "Spaceborne Striker",
	1: "Galaxy Hopper"
}

func _ready():
	Global.player = players[Global.nave]
	$Nave.texture_normal = load(naves[Global.nave])
	#$Nave.scale = Vector2(0.35, 0.35)
	#$Nave.scale.y = 0.6
	
	$AvatarNave.texture = load(avatar_naves[Global.nave])
	
	$NombreNave.text = Global.NOMBRE_NAVE[Global.nave]
	$TituloNave.text = TITULO_NAVE[Global.nave]

func _on_play_button_pressed():
	$SonidoPulsar.playing = true
	$AnimationPlayer.play("boton_play")
	#get_tree().change_scene_to_file("res://Levels/level_1.tscn")
	#pass


func _on_hero_pressed():
	$SonidoPulsar.playing = true
	get_tree().change_scene_to_file("res://Menu/heroe_seleccion.tscn")


func _on_nave_pressed():
	get_tree().change_scene_to_file("res://Menu/heroe_seleccion.tscn")


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"boton_play":
			get_tree().call_deferred("change_scene_to_file","res://Menu/load.tscn")
