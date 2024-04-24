extends Node2D

var current_pc = null

var grid = []
var astar = AStar2D.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var zones = $zones.get_children()
	for zone in zones:
		var collshape = zone.get_child(0)
		var size = collshape.shape.size
		var SIDE = Globals.TILE_SIDE
		var numrows = int(size.y/SIDE)
		var numcols = int(size.x/SIDE)
		var startx = collshape.global_position.x - size.x/2
		var starty = collshape.global_position.y - size.y/2
		print("startx starty ", startx, " ", starty)
		for row in range(numrows):
			grid.append([])
			for col in range(numcols):
				var crect = ColorRect.new()
				crect.position = Vector2(startx + col*SIDE, starty + row*SIDE)
				crect.size = Vector2(SIDE-2, SIDE-2)
				crect.color = Color(0, 0, 0, 0.3)
				
				grid[row].append(crect)
				$tiles_views.add_child(crect)

		# SET UP ASTAR
		var count: int = 0
		for row in range(numrows):
			for col in range(numcols):
				astar.add_point(count, Vector2(row,col))
				count += 1
		
		for row in range(numrows-1):
			for col in range(numcols-1):
				var id = row*numcols + col
				var rid = id + 1
				var did = id + numcols
				if col < numcols:
					astar.connect_points(id,rid)
				if row < numrows:
					astar.connect_points(id,did)

func setup_astar():
	pass

# returns row, col in v2
func tile_from_position(pos):
	var zone = zone_from_global_pos(pos)
	if not zone:
		return null
	var shape = zone.get_child(0)
	var yoffset = shape.global_position.y - shape.shape.size.y/2
	var xoffset = shape.global_position.x - shape.shape.size.x/2
	print("shape global pos", shape.global_position)
	var col = int((pos.x-xoffset)/Globals.TILE_SIDE)
	var row = int((pos.y-yoffset)/Globals.TILE_SIDE)
	return Vector2(col, row)

func zone_from_global_pos(pos):
	for zone in $zones.get_children():
		var area = zone.get_child(0)
		var shape = area.shape
		var rect: Rect2 = Rect2(area.global_position-shape.size/2, shape.size)
		if rect.has_point(pos):
			return zone
	return null

func _input(event):
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		#print("Mouse Click/Unclick at: ", event.pressed)
		#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
			
		if event.pressed:
			print("pressed")
			
			var mpos = event.position
			print("tile", tile_from_position(mpos))
			
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
						var tile_pos = tile_from_position(current_pc.global_position)
						if tile_pos:
							pass
							#grid[tile_pos.y][tile_pos.x].color = Color(1.0,0, 1.0, 1.0)
						return
			
			if current_pc:
				if event.button_index == 1: 
					current_pc.shoot_at(event.position)
				else:
					var from_tile = tile_from_position(current_pc.global_position)
					var to_tile = tile_from_position(event.position)
					
					if to_tile and from_tile:
						#grid[to_tile.y][to_tile.x].color = Color(1.0,0, 1.0, 1.0)
						var numcols = len(grid[0])
						var from_id = from_tile.y*numcols + from_tile.x
						var to_id = to_tile.y*numcols + to_tile.x
						var path = astar.get_id_path(from_id, to_id)
						print(path)
						
						var points = []
						for id in path:
							var row = int(id/numcols)
							var col = id%numcols
							var x = col*Globals.TILE_SIDE + Globals.TILE_SIDE/2
							var y = 30+row*Globals.TILE_SIDE + Globals.TILE_SIDE
							print(x,y)
							points.append(Vector2(x,y))
						
						print("Setting the following points for walking", points)
						current_pc.set_path(points)
					#current_pc.walk_to(event.position)
					
					
		
	elif event is InputEventMouseMotion:
		pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
