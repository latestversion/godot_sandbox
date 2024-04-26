extends VBoxContainer

func set_char_name(n:String):
	$namelabel.text = n
	
func set_texture(tex):
	$TextureRect.texture = tex

func add_attrib(key:String, val):
	var l = Label.new()
	
	l.text = key + " " + str(val)
	l.size = l.get_minimum_size()
	add_child(l)
