extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.position.x = 0
	$ColorRect.size = Vector2(460, 300)
	$ColorRect.position = Vector2.ZERO
	var a = {}
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()

func _input(event):
	if event is InputEventMouseButton or event is InputEventKey:
		get_tree().change_scene_to_file("res://Headquarter.tscn")

func _on_timer_timeout():
	$Label2.visible = !$Label2.visible
