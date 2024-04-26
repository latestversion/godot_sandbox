extends VBoxContainer

func set_char_name(n:String):
	$namelabel.text = n
	$namelabel.size = $namelabel.get_minimum_size()
	
func set_texture(tex):
	$TextureRect.texture = tex

func add_attrib(key:String, val):
	var l = Label.new()
	
	l.text = key + " " + str(val)
	l.size = l.get_minimum_size()
	add_child(l)
	l.size = l.get_minimum_size()
