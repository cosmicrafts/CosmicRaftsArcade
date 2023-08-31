extends Control

var naves_int = 0

var player1: String = "res://Player/player.tscn"  # 0
var player2: String = "res://Player/player2.tscn" # 1



var naves: Dictionary = {
	0: "res://Assets/menu/hero_selector/Skorn_Guide.png",
	1: "res://Assets/menu/hero_selector/aniglen_estadistica.png"
}

var fondo: Dictionary = {
	0: "res://Assets/Player/SkornBG.jpg",
	1: "res://Assets/Player/aniglen_fondo.jpg"
}


func _ready():
	$NaveEstadistcas.texture = load(naves[Global.nave])
	$Fondo.texture = load(fondo[Global.nave])


func _on_izquierda_pressed():
	$SonidoSeleccionNave.playing = true
	if !naves_int < 1:
		naves_int -= 1
		$NaveEstadistcas.texture = load(naves[naves_int])
		$Fondo.texture = load(fondo[naves_int])
	elif naves_int < naves.size() -1 :
		naves_int = naves.size() -1
		$NaveEstadistcas.texture = load(naves[naves_int])
		$Fondo.texture = load(fondo[naves_int])
	
	# asignar la nave seleccionada
	asignar_nave()


func _on_derecha_pressed():
	$SonidoSeleccionNave.playing = true
	if naves_int < naves.size() - 1:
		naves_int += 1
		$NaveEstadistcas.texture = load(naves[naves_int])
		$Fondo.texture = load(fondo[naves_int])
	elif !naves_int < 1:
		naves_int = 0
		$NaveEstadistcas.texture = load(naves[naves_int])
		$Fondo.texture = load(fondo[naves_int])
	
	asignar_nave()

func asignar_nave():
	if naves_int == 0:
		Global.player = player1
		Global.nave = 0
	elif naves_int == 1:
		Global.player = player2
		Global.nave = 1
		


func _on_select_pressed():
	Save.game_data.ship = Global.nave
	Save.save_data()  # guardamos los datos
	
	$SonidoPulsar.playing = true
	$AnimationPlayer.play("pulsar")
	#get_tree().change_scene_to_file("res://Menu/play.tscn")


func _on_play_pressed():
	Save.game_data.ship = Global.nave
	Save.save_data()  # guardamos los datos
	
	$SonidoPulsar.playing = true
	get_tree().change_scene_to_file("res://Menu/play.tscn")


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"pulsar":
			get_tree().call_deferred("change_scene_to_file","res://Menu/play.tscn")
