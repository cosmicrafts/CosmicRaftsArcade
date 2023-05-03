extends CPUParticles2D

func _ready():
	#pass
	set_emitting(true)


func _on_timer_timeout():
	queue_free()
