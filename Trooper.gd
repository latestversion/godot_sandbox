extends Node2D

var SPEED = 30
var goal = null
var shoot_goal = null
var dir = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shoot_goal:
		print("I have a shoot goal",shoot_goal)
		dir = shoot_goal - position
		var absx = abs(dir.x)
		var absy = abs(dir.y)
		if dir.y < 0:
			if absx > absy:
				print("1")
				$anim.play("shoot")
			if absx < absy:
				$anim.play("shoot_u")
				print("2")
			$anim.flip_h = dir.x > 0
		else:
			if absx > absy:
				$anim.play("shoot")
				print("3")
			if absx < absy:
				$anim.play("shoot_d")
				print("4")
			$anim.flip_h = dir.x < 0
			
		shoot_goal = null
				
	if goal:
		print("I have a goal!")
		if position.distance_squared_to(goal) < 1:
			print("Arrived at destination!")
			goal = null
			$anim.play("idle")
		else:
			dir = goal - position
			position = position + dir.normalized()*SPEED*delta
			# Figure out which animation to play
			if dir.y < 0:
				$anim.play("walk_u")
			else:
				$anim.play("walk")
			
			$anim.flip_h = dir.x < 0
	
func walk_to(pos):
	goal = pos
	
func shoot_at(pos):
	shoot_goal = pos

func _on_anim_animation_finished():
	var shooter_anims = ["shoot", "shoot_d", "shoot_u"]
	if $anim.animation in shooter_anims:
		$anim.play("idle")
		$anim.flip_h = dir.x < 0
