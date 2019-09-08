extends Label

#onready var HUD = get_parent()


func _ready():
	self.margin_left = int(get_viewport().size.x/8*3) 
	self.margin_right = int(get_viewport().size.x/4*3)
	self.margin_top = int(get_viewport().size.y/8)
	self.margin_bottom = int(get_viewport().size.y*3/8)
	#self.set_text("Mokou-sama?")
	



func _on_Text_Transition():
	self.set_text("Mokou-sama?") # Replace with function body.


func _on_Pieces_Bye():
	self.set_text("Fin") # Replace with function body.
