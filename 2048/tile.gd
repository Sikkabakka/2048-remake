extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

var speed = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
		if Input.is_action_pressed("move_right"):
			# Move as long as the key/button is pressed.
			position.x += speed * delta
	
