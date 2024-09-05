extends Control

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize_map(map_size)
	spawn_random_tile()
	label.position = Vector2(0, map_size*tilesize + 30)
	label.text = "Score:"
	
	#camera_2d.zoom = map_size/4
	pass # Replace with function body.

var map_size = 4;
var map = [];
var refrence_map = []
var tilesize = 100
var rand = RandomNumberGenerator.new()
var tile = preload("res://Tile.tscn")
var backgroundTile = preload("res://backgroundTile.tscn")
var unoccupiedSpaces = []
var border = 20
var not_moving = true
var offsett = -Vector2(calc_map_size(), calc_map_size())/2
@onready var camera_2d: Camera2D = $Camera2D

var colorDict = {
	2 : "yellow",
	4 : "orange",
	8 : "red",
	16: "blue",
	32: "forest_green",
	64: "hot_pink",
	128: "dark_red",
	256: "web_gray",
	512: "dark_salmon",
	1024: "aqua",
	2048: "crimson"
}


func initialize_map(size) -> void:

	for i in range(size):
		var mellomliste = []
		for j in range(size):
			var background = backgroundTile.instantiate()
			background.position = calc_position(Vector2(i, j))
			#background.get_node("Label").text = str(Vector2(i, j))
			add_child(background)
			
			mellomliste.append(0)
			unoccupiedSpaces.append(Vector2(i, j))
		map.append(mellomliste)
		refrence_map.append(mellomliste.duplicate())
		
func calc_map_size():
	return map_size * (tilesize + border)
func get_random_position():
	
	var randint = randi() % len(unoccupiedSpaces)
	var pos = unoccupiedSpaces[randint]
	unoccupiedSpaces.pop_at(randint)
	return (pos)
func calc_score():
	var summen = 0
	for i in range(map_size):
		for j in range(map_size):
			summen += map[i][j]
	return summen
func spawn_random_tile():
	if unoccupiedSpaces:
			
		var tileInstance = tile.instantiate()
		var pos = get_random_position()

		map[pos[0]][pos[1]] = 2
		
		
		tileInstance.get_node("ColorRect").position = calc_position(pos)
		refrence_map[pos[0]][pos[1]] = tileInstance.get_node("ColorRect")
		add_child(tileInstance)
				
var start_position_test = Vector2(1 ,1)
func test():
	print(check_down(start_position_test))
	print(check_up(start_position_test))
	print(check_right(start_position_test))
	print(check_left(start_position_test))
	
func update_maps(index, next_index):
	map[next_index[0]][next_index[1]] = map[index[0]][index[1]]
	map[index[0]][index[1]] = 0
	
	refrence_map[next_index[0]][next_index[1]] = refrence_map[index[0]][index[1]]
	refrence_map[index[0]][index[1]] = 0
	
	unoccupiedSpaces.append(index)
	unoccupiedSpaces.erase(next_index)

func merge(first_tile, next_tile):
	
	refrence_map[first_tile[0]][first_tile[1]].die()
	refrence_map[first_tile[0]][first_tile[1]] = 0
	
	var next_tile_ref = refrence_map[next_tile[0]][next_tile[1]]
	var value = map[first_tile[0]][first_tile[1]] *2
	
	next_tile_ref.get_node("Label").text = str(value)
	next_tile_ref.color = colorDict.get(value, "purple")
	
	map[next_tile[0]][next_tile[1]] = value
	map[first_tile[0]][first_tile[1]] = 0
	
	unoccupiedSpaces.append(first_tile)
	unoccupiedSpaces.erase(next_tile)
	
func calc_position(index: Vector2):
	return Vector2(index[0], index[1])*(tilesize + border) + offsett
func check_right(position: Vector2):
	for i in range(position[0]+1, map_size):
		if map[i][position[1]]:
			return Vector2(i, position[1])
	return Vector2(map_size-1 , position[1])
	
func check_left(position: Vector2):
	for i in range(position[0]-1, -1, -1):

		if map[i][position[1]]:
			return Vector2(i, position[1])
	return Vector2(0, position[1])
	
func check_down(position: Vector2):
	for i in range(position[1]+1, map_size):
		if map[position[0]][i]:
			return Vector2(position[0], i)
	return Vector2(position[0], map_size-1)

func check_up(position: Vector2):
	
	for i in range(position[1]-1, -1, -1):
		if map[position[0]][i]:
			return Vector2(position[0], i)
	return Vector2(position[0], 0)

func move_down():

	for i in range(map_size):
		for j in range(map_size-1, -1, -1):
			if refrence_map[i][j]:
				move(Vector2(i, j),check_down(Vector2(i, j)), Vector2(0, -1))
func move_up():

	for i in range(map_size):
		for j in range(1, map_size):
			if refrence_map[i][j]:
				move(Vector2(i, j),check_up(Vector2(i, j)), Vector2(0, 1))
func move_left():

	for i in range(1, map_size):
		for j in range(map_size):
			if refrence_map[i][j]:
				move(Vector2(i, j),check_left(Vector2(i, j)), Vector2(1, 0) )
func move_right():
	
	for i in range(map_size-1, -1, -1):
		for j in range(map_size):
			if refrence_map[i][j]:
				move(Vector2(i, j),check_right(Vector2(i, j)), Vector2(-1, 0) )
				
func move(first_tile, next_tile, direction):
		if first_tile != next_tile:
			if map[next_tile[0]][next_tile[1]] == 0:
				refrence_map[first_tile[0]][first_tile[1]].move(calc_position(next_tile))
				update_maps(first_tile, next_tile)
				print("move")
				print(refrence_map)
				print(map)
				print(next_tile)
				
			elif map[next_tile[0]][next_tile[1]] == map[first_tile[0]][first_tile[1]]:
				merge(first_tile, next_tile)
				print("merge")
				print(refrence_map)
				print(map)
				
			elif first_tile != next_tile+direction:
				refrence_map[first_tile[0]][first_tile[1]].move(calc_position(next_tile + direction))
				update_maps(first_tile, next_tile + direction)

	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("space"):
		spawn_random_tile()
	if not_moving:
		if Input.is_action_just_pressed("move_down"):
			move_down()
			spawn_random_tile()
		if Input.is_action_just_pressed("move_right"):
			move_right()
			spawn_random_tile()
		if Input.is_action_just_pressed("move_left"):
			move_left()
			spawn_random_tile()
		if Input.is_action_just_pressed("move_up"):
			move_up()
			spawn_random_tile()
		
		
