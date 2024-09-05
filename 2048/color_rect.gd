extends ColorRect

var speed = 10
var not_moving = true
@onready var label: Label = $Label
var value = 2
var tilesize = Vector2(100, 100)
var next_position : Vector2

var tween : Tween
var mapsize = 4


func _ready() -> void:
	if value == 2:
		label.text = "2"
		self.color = "yellow"
	
	self.size = tilesize
	self.pivot_offset = tilesize/2
	
	
	
var move_counter = 0

func move(tween_position: Vector2) -> void:
	not_moving = false
	move_counter += 1
	if tween and tween.is_running():
		position = next_position
		tween.kill()
		decrease_move()
	tween = get_tree().create_tween()
	next_position = tween_position

	tween.tween_property(self, "position",tween_position, 0.1)
	tween.connect("finished", decrease_move)
func decrease_move():
	print("signal recieved")
	move_counter -= 1
	if move_counter == 0:
		owner.move_complete.emit()
func die():
	queue_free()
func remove():
	move_counter -= 1
	
	queue_free()
func unpause():
	
	not_moving = true
