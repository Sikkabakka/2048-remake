extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize_map(map_size)
	print(map)
	pass # Replace with function body.

var map_size = 4;
var map;
func initialize_map(size) -> void:
	for i in range(size):
		var mellomliste = []
		for j in range(size):
			mellomliste.append(0)
		map.append(mellomliste)
	pass



	
func get_random_position(size):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
