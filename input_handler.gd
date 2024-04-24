extends Node2D

var current_pc = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var zones = $zones.get_children()
	for zone in zones:
		var collshape = zone.get_child(0)
		var size = collshape.shape.size
		var numrows = int(size.y/16)
		var numcols = int(size.x/16)
		var startx = collshape.position.x - size.x/2
		var starty = collshape.position.y - size.y/2
		print("startx starty ", startx, " ", starty)
		for row in range(numrows):
			for col in range(numcols):
				var crect = ColorRect.new()
				crect.position = Vector2(startx + col*16, starty + row*16)
				crect.size = Vector2(14, 14)
				#print(crect.position)
				var color_quantum = int(255/numrows)
				#crect.color = Color(color_quantum*row, color_quantum*row, 0)
				#crect.color = Color(1.0, float(row)/numrows, float(col)/numcols, 0.4)
				crect.color = Color(0, 0, 0, 0.3)
				$tiles_views.add_child(crect)

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		#print("Mouse Click/Unclick at: ", event.pressed)
		#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
		#$T1.walk_to(event.position)
			
		if event.pressed:
			print("pressed")
			var pcs = $pcs.get_children()
			for pc in pcs:
				var area = pc.find_child("selectarea")
				if area:
					print("found child!!")
					var collshape = area.get_child(0)
					var pos = collshape.global_position
					var size = collshape.shape.size
					print(pos)
					print(size)
					var rect: Rect2 = Rect2(Vector2(pos.x-size.x/2, pos.y-size.y/2), size)

					if rect.has_point(event.position):
						print("omg I selected a pc!")
						current_pc = pc
						return
			
			
			if current_pc:
				if event.button_index == 1: 
					current_pc.shoot_at(event.position)
				else: 
					current_pc.walk_to(event.position)
		
		
	elif event is InputEventMouseMotion:
		pass
		#print("Mouse Motion at: ", event.position)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
