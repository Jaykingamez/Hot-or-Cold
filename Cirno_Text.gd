extends Label

var next_scene = preload("res://Hot or Cold2.tscn")
signal Transition


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	#self.connect("Cold", self, "Setting_Of_Text", ["Cold"])
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func Setting_Of_Text(text):
	self.set_text(text)


#func _on_Mokou_Cold():
	#Setting_Of_Text("Hot.")


#func _on_Mokou_Colder():
	#Setting_Of_Text("Hotter..") # Replace with function body.


#func _on_Mokou_Coldest():
	#Setting_Of_Text("Hottest!") # Replace with function body.


func _on_Mokou_Greatest():
	Setting_Of_Text("Eye'm the greatest") # Replace with function body.


func _on_Mokou_Hot():
	Setting_Of_Text("Hot.") # Replace with function body.


func _on_Mokou_Hotter():
	Setting_Of_Text("Hotter..")  # Replace with function body.


func _on_Mokou_Hottest():
	Setting_Of_Text("Hottest!")
	emit_signal("Transition")
	self.set_draw_behind_parent(false)
	get_tree().change_scene_to(next_scene)
	
