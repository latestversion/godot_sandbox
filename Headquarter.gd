extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if not GameState.roster:
		var c = CharacterFactory.create(CharacterFactory.Type.TROOPER)
		GameState.add_to_roster(c)
		c = CharacterFactory.create(CharacterFactory.Type.TROOPER)
		GameState.add_to_roster(c)
	
