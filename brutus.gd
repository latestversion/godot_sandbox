extends CharacterBody2D

var resource = load("res://example.dialogue")
var dialogue_line = null

func _ready():
	$anim.play("idle")
	$anim.flip_h = true
	$Timer.start()

func _on_timer_timeout():
	if dialogue_line:
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, dialogue_line.next_id)
	else:
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
	#DialogueManager.show_dialogue_balloon(resource, "start")
	$DialogueLabel.dialogue_line = dialogue_line
	$DialogueLabel.seconds_per_pause_step = 1
	await $DialogueLabel.type_out()
	
func _on_timer_timeout1():
	if dialogue_line:
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, dialogue_line.next_id)
	else:
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
	$DialogueLabel.dialogue_line = dialogue_line
	$DialogueLabel.type_out()
	if dialogue_line:
		print(dialogue_line.text)
	
func _on_area_2d_area_entered(area):
	print("You entered the area")
	var label = Label.new()
	print(label.position)
	label.text = "You entered the area"
	label.name = "saylabel"
	add_child(label)
	var ssl = SimpleSayLabel.new("heppo")
	add_child(ssl)

func _on_area_2d_area_exited(area):
	for child in get_children():
		if child.name == "saylabel":
			child.queue_free()
			break
	print("You left the area")
