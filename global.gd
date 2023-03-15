extends Node


@onready var score:int
@onready var rng:RandomNumberGenerator = RandomNumberGenerator.new()

# velocidad de disparo del player
@onready var bala_timer:float = 1.0

@onready var cañon: int = 1

var player: String

func random(min_number, max_number):
	rng.randomize()
	var random = rng.randf_range(min_number, max_number)
	return random
