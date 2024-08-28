
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

var speed = 10

var tween = get_tree().create_tween()


func move(position: int) -> void:
	tween.tween_property($Sprite)
	pass
		
	
