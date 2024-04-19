class_name SimpleSayLabel extends Label

var timer = null

func _init(text: String):
	self.text = text
	timer = Timer.new()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	var theme = load("res://text_theme.tres")
	if theme:
		print("tjotjto")
	self.theme = theme
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = 1.0
	timer.paused = false
	#timer.timeout.connect(_on_timeout)
	timer.timeout.connect(on_timeout)
	timer.start()
	print(timer.time_left)

func on_timeout():
	print("TIEMOTU")
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
