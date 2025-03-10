extends Button

func _pressed():
	self.get_parent().queue_free()
