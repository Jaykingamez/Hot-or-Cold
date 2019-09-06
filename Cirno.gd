extends "piece.gd"

onready var Grid = get_parent()
var new_position : bool = false 
var target_position 

func _ready():
	#update_look_direction(Vector2(1,0))
	pass

# Called when the node enters the scene tree for the first time.
func _process(delta):
	var input_direction = get_input_direction()
	if not input_direction:
		return
	#update_look_direction(input_direction)
	
	var target_position = Grid.request_move(self, input_direction)
	if target_position is Vector2: #target_position
		move_to(target_position)
	else:  #Insert animations here when bump into something one is not supposed to
		bump()
	
func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"))
	)
	
func update_look_direction(direction):
	$Pivot/Sprite.rotation = direction.angle()
	
func move_to(target_position):
	set_process(false) #This is for the _process function, so player can't input anything
	$AnimationPlayer.play("walk")
	
	
	#Move node to target cell immediately
	#animate sprite moving from start to finish
	var move_direction = (target_position - self.position).normalized()
	# InterpolatreWalk animation 
	#$Tween.interpolate_property($Pivot, "position", -move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_BACK, Tween.EASE_OUT)
	self.position = target_position
	new_position = true
	
	#$Tween.start() #Play animation
	yield($AnimationPlayer , "animation_finished")
	new_position = false
	
	set_process(true)
	
func bump(): #bump animation
	set_process(false)
	$AnimationPlayer.play("walk")
	yield($AnimationPlayer, "animation_finished")
	set_process(true)
	
	
	


