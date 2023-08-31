extends Node

const SAVEFILE = "user://savefile.save"

var game_data = {
	"ship": 0,
	"life": 3,
	"level": 1
}


func _ready():
	load_data()


func load_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.READ)
	if file == null:
		save_data()
	else:
		game_data = file.get_var()
	file = null # para cerrar el archivo

func save_data():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	file.store_var(game_data)
	file = null
