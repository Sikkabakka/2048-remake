extends ColorRect

var speed = 10
var not_moving = true
@onready var label: Label = $Label
var value = 2
var tilesize = Vector2(100, 100)
var next_position : Vector2
# Called when the node enters the scene tree for the first time.

var tween : Tween
var mapsize = 4
func _ready() -> void:
	if value == 2:
		label.text = "2"
		self.color = "yellow"
	
	self.size = tilesize
	self.pivot_offset = tilesize/2
	
	
	

func move(tween_position: Vector2) -> void:
	not_moving = false

	if tween and tween.is_running():
		position = next_position
		tween.kill()
	
	tween = get_tree().create_tween()
	next_position = tween_position

	tween.tween_property(self, "position",tween_position, 0.1)
	tween.connect("finished", unpause)
func die():
	queue_free()
func remove():
	queue_free()
func unpause():
	
	not_moving = true
