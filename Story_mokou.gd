extends Label

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.margin_left = int(get_viewport().size.x/8*3) 
	self.margin_right = int(get_viewport().size.x/4*3)
	self.margin_top = int(get_viewport().size.y/8)
	self.margin_bottom = int(get_viewport().size.y*3/8)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Text_Transition():
	self.set_text("Here I'll help you")
