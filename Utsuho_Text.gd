extends Label
signal StandProud

func _ready():
	set_process(false)


func _on_Pieces_Stand():
	self.set_text("Look within yourself, and SPACEBAR up!")
	set_process(true)
	
func _process(delta):
	if Input.is_action_pressed("ui_select"):
		emit_signal("StandProud")
		self.set_text("MOKOUIAN RED")
		set_process(false)
		