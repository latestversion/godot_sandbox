extends CharacterBody2D

var resource = load("res://example.dialogue")
var dialogue_line = null

var lines = ["Hello.", "What a lovely day.", "Orcs are the best.", "Simply the best."]
var idx = 0

func _ready():
	$anim.play("idle")
	$anim.flip_h = true
	$Timer.wait_time = 2
	$Timer.one_shot = false
	$Timer.start()
	
func _on_timer_timeout():
	var ssl = SimpleSayLabel.new(lines[idx])
	idx += 1
	idx = idx % lines.size()
	add_child(ssl)
	ssl.position = Vector2(-1*ssl.size.x/2, -$CollisionShape2D.shape.size.y-10)
	$Timer.wait_time = 2 + randi_range(1,10)

func _on_timer_timeout2():
	if dialogue_line:
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, dialogue_line.next_id)
	else:
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
	#DialogueManager.show_dialogue_balloon(resource, "start")
	$DialogueLabel.dialogue_line = dialogue_line
	$DialogueLabel.seconds_per_pause_step = 1
	#await $DialogueLabel.type_out()
	
func _on_area_2d_area_entered(area):
	pass

func _on_area_2d_area_exited(area):
	pass
