extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.rect_size = get_viewport().size
	self.hide()
	




func _on_Text_Transition():
	self.show() # Replace with function body.
