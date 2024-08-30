extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize_map(map_size)
	spawn_tile()
	pass # Replace with function body.

var map_size = 4;
var map = [];
var refrence_map = []
var tilesize = 100
var rand = RandomNumberGenerator.new()
var tile = preload("res://Tile.tscn")
var unoccupiedSpaces = []

var not_moving = true


func initialize_map(size) -> void:
	for i in range(size):
		var mellomliste = []
		for j in range(size):
			mellomliste.append(0)
			unoccupiedSpaces.append(Vector2(i, j))
		map.append(mellomliste)
		refrence_map.append(mellomliste.duplicate())



	
func get_random_position():
	
	var randint = randi() % len(unoccupiedSpaces)
	var pos = unoccupiedSpaces[randint]
	unoccupiedSpaces.pop_at(randint)
	return (pos)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func spawn_tile():
	var tileInstance = tile.instantiate()
	var pos = get_random_position()
	print(pos)
	map[pos[0]][pos[1]] = 2
	
	print("spawn at" , Vector2(pos[0], pos[1])*tilesize - Vector2(tilesize, tilesize)/2)
	tileInstance.get_node("ColorRect").position = Vector2(pos[0], pos[1])*tilesize - Vector2(tilesize, tilesize)/2
	refrence_map[pos[0]][pos[1]] = tileInstance.get_node("ColorRect")
	add_child(tileInstance)
	
	




'''
Lag en funksjon for hver vei som sjekker nærmeste tile. så sjekk om de kan merges, merges hvis eller plasser på forrige tile
'''
				
var start_position_test = Vector2(1 ,1)
func test():
	print(check_down(start_position_test))
	print(check_up(start_position_test))
	print(check_right(start_position_test))
	print(check_left(start_position_test))
	
	
func check_down(position: Vector2):
	for i in range(position[0]+1, map_size):
		if map[i][position[1]]:
			return Vector2(i, position[1])
	return Vector2(map_size-1 , position[1])
	
func check_up(position: Vector2):
	for i in range(position[0]-1, -1, -1):

		if map[i][position[1]]:
			return Vector2(i, position[1])
	return Vector2(0, position[1])
	
func check_right(position: Vector2):
	for i in range(position[1]+1, map_size):
		if map[position[0]][i]:
			return Vector2(position[0], i)
	return Vector2(position[0], map_size-1)

func check_left(position: Vector2):
	for i in range(position[1]-1, -1, -1):
		if map[position[0]][i]:
			return Vector2(position[0], i)
	return Vector2(position[0], 0)
func move_right():

	for i in range(map_size):
		for j in range(map_size-1):
			if refrence_map[i][j]:
				print("found tile", i, j)
				var next_tile = check_right(Vector2(i, j))
				print(map)
				print(next_tile)
				print("position now", refrence_map[i][j].position)
				if map[next_tile[0]][next_tile[1]] == 0:
					print(Vector2(next_tile[0], next_tile[1])*tilesize)
					refrence_map[i][j].move(Vector2(next_tile[0], next_tile[1])*tilesize - Vector2(tilesize, tilesize)/2)
					
					
func move_left():
	
	for i in range(map_size):
		
		for j in range(1, map_size):
			if refrence_map[i][j]:
				var next_tile = check_left(Vector2(i, j))
				print(map)
				if map[next_tile[0]][next_tile[1]] == 0:
					print("should move")
					refrence_map[i][j].move(Vector2(next_tile[0], next_tile[1])*tilesize)
			
	


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		spawn_tile()
	if not_moving:
		if Input.is_action_just_pressed("move_down"):
			pass
		if Input.is_action_just_pressed("move_right"):
			move_right()
		if Input.is_action_just_pressed("move_left"):
			move_left()
		if Input.is_action_just_pressed("move_up"):
			pass

	
