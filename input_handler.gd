extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.pressed:
		print("Mouse Click/Unclick at: ", event.position)
		print("Mouse Click/Unclick at: ", event.pressed)
		#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
		#$T1.walk_to(event.position)
		$T1.shoot_at(event.position)
		
	elif event is InputEventMouseMotion:
		pass
		#print("Mouse Motion at: ", event.position)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
