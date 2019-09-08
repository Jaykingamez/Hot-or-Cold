extends TileMap

enum {EMPTY = -1, CIRNO, UTSUHO, MOKOU, OBSTACLE, PROJECTILE, YELLOW}
onready var Cirno = $Cirno
onready var Utsuho = $Utsuho
onready var the_grid = get_parent()
var TOP: int = -1
var BOTTOM : int = 10
var LEFT: int = -4
var RIGHT: int = 18





func _ready():
	#for child in get_children():
		#set_cellv(world_to_map(child.position), child.type)
	Cirno.position = map_to_world(Vector2(7,9))  #Make it procedural ?
	Utsuho.position = map_to_world(Vector2(7,0))
	for width in range(the_grid.WIDTH-the_grid.STARTING_POSITION.x):
		for height in range(the_grid.HEIGHT-the_grid.STARTING_POSITION.y):
			if width == 0 or height == 0 or width == the_grid.WIDTH-the_grid.STARTING_POSITION.x-1  or height == the_grid.HEIGHT-the_grid.STARTING_POSITION.y-1:
				set_cellv(Vector2(width+the_grid.STARTING_POSITION.x,height+the_grid.STARTING_POSITION.y), OBSTACLE)
	Utsuho_SpellCard2()


			
	
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
		YELLOW:
			get_tree().reload_current_scene()
		PROJECTILE:
			get_tree().reload_current_scene()

func update_piece_position(piece, cell_start, cell_target):
	set_cellv(cell_target, piece.type) 
	set_cellv(cell_start, EMPTY)
	return map_to_world(cell_target)
	
	
func Utsuho_SpellCard1():
	var target = world_to_map(Cirno.position)
	#var firer = world_to_map(Utsuho.position)
	var end_of_projectile: Vector2 = Vector2(target.x, TOP+1)
	var new_target: bool = false
	var affected_tiles : Array = []
	var spread_shot: int = 2
	var long_shot: int = 3
	var count: int = 0
	while spread_shot !=5:
		target = world_to_map(Cirno.position)
		#var firer = world_to_map(Utsuho.position)
		for x in range(spread_shot):
			for y in range(long_shot):
				if end_of_projectile.y-y+1<BOTTOM and end_of_projectile.x-x+1>LEFT and end_of_projectile.x-x+1<RIGHT:
					set_cellv(Vector2(end_of_projectile.x-x+1, end_of_projectile.y-y+1), PROJECTILE)
					affected_tiles.append(Vector2(end_of_projectile.x-x+1, end_of_projectile.y-y+1))
				elif end_of_projectile.y-y+1==BOTTOM:
					new_target = true
		yield(get_tree().create_timer(0.25),"timeout")
		if get_cellv(world_to_map(Cirno.position)) == PROJECTILE or get_cellv(world_to_map(Cirno.position)) == YELLOW:
			get_tree().reload_current_scene()
		if new_target == false:			
			end_of_projectile = Vector2(end_of_projectile.x, end_of_projectile.y+3)
		else:
			end_of_projectile = Vector2(target.x, TOP+1)
			new_target = false
			for tile in affected_tiles:
				set_cellv(tile, EMPTY)
			affected_tiles = []	
			count += 1
			if count % 5 == 0:
				spread_shot += 1
	Utsuho_SpellCard2()
				
func Utsuho_SpellCard2():
	var target = world_to_map(Cirno.position)
	var firer = world_to_map(Utsuho.position)
	var projectile_tiles = []
	var new_projectile_tiles = []
	var laser_tiles = []
	var laser_wipe: bool = false
	var laser = Vector2(target.x, TOP)
	var count = 0
	while count !=5:
		print(count)
		target = world_to_map(Cirno.position)
		for y in range(firer.y-TOP):
			if (firer.y-(y+1)>=TOP):
				#projectile_tiles.append(Vector2(firer.x-(y+1),firer.y-(y+1))) # Making a cross duh
				set_cellv(Vector2(firer.x-(y+1),firer.y-(y+1)), YELLOW) # Top Left
				projectile_tiles.append(Vector2(firer.x-(y+1),firer.y-(y+1)))
				set_cellv(Vector2(firer.x+(y+1),firer.y-(y+1)), YELLOW) # Top Right
				projectile_tiles.append(Vector2(firer.x+(y+1),firer.y-(y+1)))
		for y in range(BOTTOM-firer.y):
			if firer.y+(y+1)<=BOTTOM-1:
				set_cellv(Vector2(firer.x-(y+1),firer.y+(y+1)), YELLOW) #Bottom Left
				projectile_tiles.append(Vector2(firer.x-(y+1),firer.y+(y+1)))
				set_cellv(Vector2(firer.x+(y+1),firer.y+(y+1)), YELLOW) #Bottom Right
				projectile_tiles.append(Vector2(firer.x+(y+1),firer.y+(y+1)))
		#for y in range(3):
			#set_cellv(Vector2(laser.x, laser.y+y), PROJECTILE)
			#laser_tiles.append(Vector2(laser.x, laser.y+y))
		laser = Vector2(laser.x, laser.y+3)
		yield(get_tree().create_timer(1),"timeout")
		if get_cellv(world_to_map(Cirno.position)) == PROJECTILE or get_cellv(world_to_map(Cirno.position)) == YELLOW:
			get_tree().reload_current_scene()
		while projectile_tiles:
			
			for tile in projectile_tiles:
				if tile.y+1<=BOTTOM-1:
					new_projectile_tiles.append(Vector2(tile.x,tile.y+1))
					set_cellv(Vector2(tile.x,tile.y+1),YELLOW)
				set_cellv(tile,EMPTY)
			
			projectile_tiles = new_projectile_tiles
			new_projectile_tiles = []
			
			for y in range(3):
				if laser.y+y <= BOTTOM-1:
					set_cellv(Vector2(laser.x, laser.y+y), PROJECTILE)
					laser_tiles.append(Vector2(laser.x, laser.y+y))
				else:
					laser_wipe = true
					laser = Vector2(target.x, TOP)
			
				
			yield(get_tree().create_timer(0.3),"timeout")
			if get_cellv(world_to_map(Cirno.position)) == PROJECTILE or get_cellv(world_to_map(Cirno.position)) == YELLOW:
				get_tree().reload_current_scene()
			if laser_wipe == true:
				for tile in laser_tiles:
					set_cellv(tile, EMPTY)	
				laser_wipe = false
				laser_tiles = []
				target = world_to_map(Cirno.position)
			else:
				laser = Vector2(laser.x, laser.y+3)
		count += 1
	
	
		
		
	
		
	
				
		
	
	