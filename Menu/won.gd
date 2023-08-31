extends Control



func _on_continue_pressed():
	$SonidoPulsar.playing = true
	$AnimationPlayer.play("pulsar")
	#get_tree().change_scene_to_file("res://Menu/play.tscn")


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"pulsar":
			get_tree().call_deferred("change_scene_to_file","res://Menu/load.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://Menu/play.tscn")
