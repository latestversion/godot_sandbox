class_name Character

var attribs = {}:
	set(value):
		attribs = value
	get:
		return attribs
		
func attrib(key):
	if attribs.has(key):
		return attribs[key]
	return null

func set_attrib(key, val):
	attribs[key] = val

func has_attrib(key):
	return attribs.has(key)

var things : int :
	set(value):
		if value != things:
			var old_val = things
			things = value
			


func _init():
	pass
