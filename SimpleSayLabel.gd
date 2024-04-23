class_name SimpleSayLabel extends Label

var timer = null
var anchor = null

func _init(text: String):
	self.text = text
	timer = Timer.new()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	var theme = load("res://text_theme.tres")
	self.theme = theme
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = 1.0
	timer.paused = false
	#timer.timeout.connect(_on_timeout)
	timer.timeout.connect(on_timeout)
	timer.start()
	size = get_minimum_size()

func on_timeout():
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
