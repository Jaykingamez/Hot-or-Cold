extends TileMap
var SQUARES9: Array = [-1,0,1]
var WIDTH: int = 19 #Number of squares
var HEIGHT: int = 11
var STARTING_POSITION: Vector2 = Vector2(-4,-2)
enum TYPE_OF_GRID {COVER, FOG}
onready var Cirno = $Pieces/Mokou
onready var Pieces = $Pieces


# Called when the node enters the scene tree for the first time.
func _ready():
	for width in range(WIDTH-STARTING_POSITION.x):
		for height in range(HEIGHT-STARTING_POSITION.y):
			if width == 0 or height == 0 or width == (WIDTH-STARTING_POSITION.x-1) or height == HEIGHT-STARTING_POSITION.y-1 :
				pass
			else:
				set_cellv(Vector2(width+STARTING_POSITION.x,height+STARTING_POSITION.y), TYPE_OF_GRID.FOG)

func _process(delta):
	if Cirno.get_input_direction() and !Cirno.new_position:
		var player_position = world_to_map(Cirno.position)
		for x in SQUARES9:
			for y in SQUARES9:
				if (player_position.x+x) != -4 and player_position.y+y!=-2 and (player_position.x+x) != 18:
					set_cellv(Vector2(player_position.x+x,player_position.y+y), TYPE_OF_GRID.FOG)
	elif Cirno.new_position:
		var player_position = world_to_map(Cirno.position)
		for x in SQUARES9:
			for y in SQUARES9:
				if (player_position.x+x) != -4 and player_position.y+y!=-2 and (player_position.x+x) != 18:
					set_cellv(Vector2(player_position.x+x,player_position.y+y), TYPE_OF_GRID.COVER)





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
