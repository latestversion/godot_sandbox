extends Node2D

var SPEED = 30
var goal = null
var dir = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if goal:
		print("I have a goal!")
		if position.distance_squared_to(goal) < 1:
			goal = null
			$anim.play("idle")
		else:
			dir = goal - position
			position = position + dir.normalized()*SPEED*delta
			if dir.y < 0:
				$anim.play("walk_u")
			else:
				$anim.play("walk")
			
			$anim.flip_h = dir.x < 0
	
			# Figure out which animation to play
	
	
func walk_to(pos):
	goal = pos
	
