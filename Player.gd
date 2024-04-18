extends CharacterBody2D


const SPEED = 105.0


func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)	
		
	direction = Input.get_axis("up", "down")
	
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)
	
	velocity = velocity.normalized()*SPEED
	
	if velocity.x < 0:
		$anim.flip_h = true
	else:
		if velocity.x > 0:
			$anim.flip_h = false
		
	if velocity.x != 0 or velocity.y != 0:
		$anim.play("walk_r")
	else:
		$anim.play("idle")
		
		


	move_and_slide()
