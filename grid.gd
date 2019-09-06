extends TileMap

enum {EMPTY = -1, CIRNO, UTSUHO, MOKOU, OBSTACLE}
onready var mokou = $Mokou
onready var the_grid = get_parent()




func _ready():
	#for child in get_children():
		#set_cellv(world_to_map(child.position), child.type)
	mokou.position = map_to_world(Vector2(15,9))  #Make it procedural ?
	mokou.set_z_index(-1)
	for width in range(the_grid.WIDTH-the_grid.STARTING_POSITION.x):
		for height in range(the_grid.HEIGHT-the_grid.STARTING_POSITION.y):
			if width == 0 or height == 0 or width == the_grid.WIDTH-the_grid.STARTING_POSITION.x-1  or height == the_grid.HEIGHT-the_grid.STARTING_POSITION.y-1:
				set_cellv(Vector2(width+the_grid.STARTING_POSITION.x,height+the_grid.STARTING_POSITION.y), OBSTACLE)


			
	
func get_cell_piece(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)

func request_move(piece, direction):
	var cell_start = world_to_map(piece.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)

	
	match cell_target_type:
		EMPTY:
			return update_piece_position(piece, cell_start, cell_target)
		#OBSTACLE:  #Pickup stuff
			#var object_piece = get_cell_piece(cell_target)
			#object_piece.queue_free()
			#return update_piece_position(piece, cell_start, cell_target)
		OBSTACLE:
			return 'Obstacle'
		CIRNO:
			var piece_name = get_cell_piece(cell_target).name
			print("Cell %s contains %s" %[cell_target, piece_name])
			#return false

func update_piece_position(piece, cell_start, cell_target):
	set_cellv(cell_target, piece.type) 
	set_cellv(cell_start, EMPTY)
	return map_to_world(cell_target)