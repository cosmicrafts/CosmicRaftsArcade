extends Node


@onready var score:int # puntos del jugador por matar
@onready var rng:RandomNumberGenerator = RandomNumberGenerator.new()

# velocidad de disparo del player
@onready var bala_timer:float = 1.0

@onready var cañon: int = 1  # cantidad de cañones activos 

var player: String 
var nave: int  # numero de la nave a utilizar
var nivel: int # el numero de nivel a jugar
var vida: int   # la vida del jugador

const NOMBRE_NAVE: Dictionary = {
	0: "Skorn",
	1: "Aniglen"
}


func random(min_number, max_number):
	rng.randomize()
	var random = rng.randf_range(min_number, max_number)
	return random
