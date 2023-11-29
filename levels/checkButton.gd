extends CheckButton

@export var transitioner : transitions






func _on_toggled(button_pressed):
	transitioner.set_next_animation(button_pressed)
