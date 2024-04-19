extends CharacterBody2D

var resource = load("res://example.dialogue")
var dialogue_line = null

func _ready():
	$anim.play("idle")
	$anim.flip_h = true
	#$Timer.start()

func _on_timer_timeout():
	if dialogue_line:
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, dialogue_line.next_id)
	else:
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
	#DialogueManager.show_dialogue_balloon(resource, "start")
	$DialogueLabel.dialogue_line = dialogue_line
	$DialogueLabel.seconds_per_pause_step = 1
	#await $DialogueLabel.type_out()
	
func _on_area_2d_area_entered(area):
	var ssl = SimpleSayLabel.new("heppo")
	add_child(ssl)

func _on_area_2d_area_exited(area):
	print("You left the area")
