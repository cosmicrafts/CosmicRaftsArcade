extends Area2D


func _ready():
	$AnimationPlayer.play("activate")


func _on_area_entered(area):
	if area.is_in_group("Bala"):
		$AnimationPlayer.play("damage")
		#pass
