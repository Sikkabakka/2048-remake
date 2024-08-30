extends ColorRect

var speed = 10
var not_moving = true
@onready var label: Label = $Label
var value = 2
var tilesize = Vector2(100, 100)
# Called when the node enters the scene tree for the first time.


var mapsize = 4
func _ready() -> void:
	if value == 2:
		label.text = "2"
		self.color = "yellow"
	self.size = tilesize
	
	
	

func move(position: Vector2) -> void:
	not_moving = false
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position",position, 0.1)
	tween.connect("finished", unpause)
			
func unpause():
	
	not_moving = true
