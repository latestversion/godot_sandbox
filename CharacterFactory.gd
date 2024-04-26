class_name CharacterFactory

enum Type {TROOPER, HUGGER}

const trooper_names = ["Rolf", "Karl", "Johan", "Nils", "Roger", "Jonsson", "Rask", "Max"]

static func create(type: Type):
	if type == Type.TROOPER:
		var c = Character.new()
		c.set_attrib("move", 4)
		c.set_attrib("hp", 3)
		c.set_attrib("ss", 50)
		c.set_attrib("cc", 20)
		c.set_attrib("name", trooper_names.pick_random())
		c.set_attrib("type", type)
		return c
	if type == Type.HUGGER:
		var c = Character.new()
		c.set_attrib("move", 5)
		c.set_attrib("hp", 5)
		c.set_attrib("ss", 0)
		c.set_attrib("cc", 50)
		c.set_attrib("name", "Hugger")
		c.set_attrib("type", type)
		return c
	
		
func _init():
	pass
