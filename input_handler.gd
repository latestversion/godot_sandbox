extends Node2D

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
				print(crect.position)
				var color_quantum = int(255/numrows)
				print(color_quantum)
				#crect.color = Color(color_quantum*row, color_quantum*row, 0)
				print("cq",color_quantum*row)
				#crect.color = Color(1.0, float(row)/numrows, float(col)/numcols, 0.4)
				crect.color = Color(0, 0, 0, 0.1)
				print(crect.color)
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
			if event.button_index == 1:
				$T1.shoot_at(event.position)
			else: 
				$T1.walk_to(event.position)
		
		
	elif event is InputEventMouseMotion:
		pass
		#print("Mouse Motion at: ", event.position)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
