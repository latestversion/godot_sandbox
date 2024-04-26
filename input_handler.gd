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
		
		for row in range(numrows):
			for col in range(numcols):
				var id = row*numcols + col
				var rid = id + 1
				var did = id + numcols
				if col < numcols-1:
					astar.connect_points(id,rid)
				if row < numrows-1:
					astar.connect_points(id,did)
		
		var unwalks = $unwalkables.get_children()
		for u in unwalks:
			var t = tile_from_position(u.position)
			var row = t.y
			var col = t.x
			grid[row][col].color = Color(1.0,1.0,0,0.1)
			var id = row*numcols + col
			var rid = id + 1
			var lid = id - 1
			var did = id + numcols
			var uid = id - numcols
			if row > 0:
				astar.disconnect_points(id, uid)
			if row < numrows-1:
				astar.disconnect_points(id, did)
			if col > 0:
				astar.disconnect_points(id, lid)
			if col < numcols-1:
				astar.disconnect_points(id, rid)

func setup_astar():
	pass

# returns col, row in v2
func tile_from_position(pos):
	var zone = zone_from_global_pos(pos)
	
	if not zone:
		return null
	var shape = zone.get_child(0)
	var yoffset = shape.global_position.y - shape.shape.size.y/2
	var xoffset = shape.global_position.x - shape.shape.size.x/2
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
		if event.pressed:
			var mpos = event.position
			
			var pcs = $pcs.get_children()
			for pc in pcs:
				var area = pc.find_child("selectarea")
				if area:
					var collshape = area.get_child(0)
					var pos = collshape.global_position
					var size = collshape.shape.size
					var rect: Rect2 = Rect2(Vector2(pos.x-size.x/2, pos.y-size.y/2), size)

					if rect.has_point(event.position):
						print("omg I selected a pc!")
						if current_pc:
							current_pc.deselect()
						current_pc = pc
						current_pc.select()
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
					
					if to_tile != null and from_tile != null:
						#grid[to_tile.y][to_tile.x].color = Color(1.0,0, 1.0, 1.0)
						var numcols = len(grid[0])
						var from_id = from_tile.y*numcols + from_tile.x
						var to_id = to_tile.y*numcols + to_tile.x
						var path = astar.get_id_path(from_id, to_id)
						
						var points = []
						for id in path:
							var row = int(id/numcols)
							var col = id%numcols
							var x = col*Globals.TILE_SIDE + Globals.TILE_SIDE/2
							var y = 32+row*Globals.TILE_SIDE + Globals.TILE_SIDE/2
							points.append(Vector2(x,y))
						
						current_pc.set_path(points)
					#current_pc.walk_to(event.position)
					
	elif event is InputEventMouseMotion:
		pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
