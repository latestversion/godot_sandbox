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
	await $DialogueLabel.type_out()
	
	
func _on_timer_timeout1():
	if dialogue_line:
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, dialogue_line.next_id)
	else:
		dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
	#DialogueManager.show_dialogue_balloon(resource, "start")
	$DialogueLabel.dialogue_line = dialogue_line
	
	$DialogueLabel.type_out()
	if dialogue_line:
		print(dialogue_line.text)
		#$Timer.start()
	#var label = get_node("root/Node2D/DialogueLabel")
	
func _on_timer_timeout2():
	DialogueManager.show_dialogue_balloon(resource, "start")
	
func _on_area_2d_area_entered(area):
	print("You entered the area")
	var label = Label.new()
	#label.position = position - Vector2(10,60)
	print(label.position)
	label.text = "You entered the area"
	add_child(label)


func _on_area_2d_area_exited(area):
	print("You left the area")
