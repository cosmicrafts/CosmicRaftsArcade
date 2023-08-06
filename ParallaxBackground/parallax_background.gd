extends ParallaxBackground


@export var speed:int
var offset_scroll = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func _physics_process(delta):
	#print("speed:", speed)
	offset_scroll += speed * delta
	#print("offset:",offset_scroll)
	set_scroll_offset(Vector2(0, offset_scroll))
	#self.set_scroll_offset(Vector2(0, offset_scroll))
	#scroll_offset = Vector2(0, offset_scroll)
	
