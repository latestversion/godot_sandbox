extends Node

var roster = []

func add_to_roster(c: Character):
	roster.append(c)
# Called when the node enters the scene tree for the first time.
func _ready():
	print("GameState ready")
