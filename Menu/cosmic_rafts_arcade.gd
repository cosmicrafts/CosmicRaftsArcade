extends Control


func _on_timer_timeout():
	get_node("AnimationPlayer").play("Intro")


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Intro":
			get_tree().call_deferred("change_scene_to_file","res://Menu/menu.tscn")
