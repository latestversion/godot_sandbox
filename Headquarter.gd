extends Node2D
@onready var roster_ui_scene = preload("res://RosterCharacterSquareUI.tscn")

func make_ui(roster):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	if len(GameState.roster) == 0:
		var c = CharacterFactory.create(CharacterFactory.Type.TROOPER)
		GameState.add_to_roster(c)
		c = CharacterFactory.create(CharacterFactory.Type.TROOPER)
		GameState.add_to_roster(c)
		c = CharacterFactory.create(CharacterFactory.Type.TROOPER)
		GameState.add_to_roster(c)
		c = CharacterFactory.create(CharacterFactory.Type.TROOPER)
		GameState.add_to_roster(c)
	
	for c in GameState.roster:
		var rui = roster_ui_scene.instantiate()
		rui.set_char_name(c.attrib("name"))
		rui.add_attrib("move",c.attrib("move"))
		rui.add_attrib("shoot",c.attrib("ss"))
		rui.add_attrib("fight",c.attrib("cc"))
		rui.add_attrib("hit points",c.attrib("hp"))
		$RosterUI/GridContainer.add_child(rui)
	
	
	
