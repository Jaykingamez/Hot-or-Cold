extends Label

#onready var HUD = get_parent()


func _ready():
	self.margin_left = int(get_viewport().size.x/2) 
	self.margin_right = get_viewport().size.x

