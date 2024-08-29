extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize_map(map_size)
	print(get_random_position(map_size))
	pass # Replace with function body.

var map_size = 4;
var map = [];
var rand = RandomNumberGenerator.new()


func initialize_map(size) -> void:
	for i in range(size):
		var mellomliste = []
		for j in range(size):
			mellomliste.append(0)
		map.append(mellomliste)


	
func get_random_position(size):
	return ([ randi_range(size, size), randi_range(size, size)])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
