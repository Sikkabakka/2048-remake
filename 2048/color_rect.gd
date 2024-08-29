extends ColorRect

var speed = 10
var not_moving = true
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = "16"	
	pass # Replace with function body.




func move(position: Vector2) -> void:
	not_moving = false
	print("false")
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position",position, 0.1)
	tween.connect("finished", unpause)
			
func unpause():
	print("true")
	not_moving = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not_moving:
		if Input.is_action_just_pressed("move_down"):
			move(Vector2(self.position[0], self.position[1]+100))
			
		if Input.is_action_just_pressed("move_right"):
			move(Vector2(self.position[0] +100, self.position[1]))
		if Input.is_action_just_pressed("move_left"):
			move(Vector2(self.position[0]-100, self.position[1]))
		if Input.is_action_just_pressed("move_up"):
			move(Vector2(self.position[0], self.position[1]-100))
