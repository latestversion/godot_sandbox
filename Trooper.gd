extends Node2D

var SPEED = 50
var goal = null
var path = []
var shoot_goal = null
var dir = Vector2(0, 0)
var shootsound = preload("res://sounds/pistol.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("idle")
	$audio.stream = shootsound
	
func select():
	$anim.modulate = Color(1,0,1)

func deselect():
	$anim.modulate = Color(1,1,1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shoot_goal:
		dir = shoot_goal - position
		var absx = abs(dir.x)
		var absy = abs(dir.y)
		if absx >= absy:
			$anim.play("shoot")
			$anim.flip_h = dir.x < 0
		else:
			if dir.y < 0:
				$anim.play("shoot_u")
				$anim.flip_h = dir.x > 0
			else:
				$anim.play("shoot_d")
				$anim.flip_h = dir.x < 0
		
		$audio.play()
		shoot_goal = null
		return
				
	if goal:
		if position.distance_squared_to(goal) < 1:
			position = goal
			goal = null
			goal = path.pop_front()
			if not goal:
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

func set_path(points):
	points.pop_front()
	path = points
	goal = points.pop_front()

func walk_to(pos):
	goal = pos
	
func shoot_at(pos):
	shoot_goal = pos

func _on_anim_animation_finished():
	var shooter_anims = ["shoot", "shoot_d", "shoot_u"]
	if $anim.animation in shooter_anims:
		$anim.play("idle")
		$anim.flip_h = dir.x < 0
