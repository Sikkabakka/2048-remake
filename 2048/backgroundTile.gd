extends Control

@onready var color_rect: ColorRect = $ColorRect

@onready var color_rect_2: ColorRect = $ColorRect/ColorRect2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.position = Vector2(0, 0)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
