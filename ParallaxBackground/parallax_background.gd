extends ParallaxBackground


@export var speed:int
var offset_scroll = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset_scroll += speed * delta
	
	set_scroll_offset(Vector2(0 , offset_scroll))
