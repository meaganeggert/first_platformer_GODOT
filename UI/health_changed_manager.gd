extends Control

@export var health_changed_label : PackedScene
@export var damage_color : Color = Color.DARK_RED
@export var heal_color : Color = Color.DARK_GREEN

func _ready():
	SignalBus.connect("on_health_changed", on_signal_health_changed)
	
func on_signal_health_changed(node : Node, amount_changed : int):
	var label_instance : Label = health_changed_label.instantiate()
	if node:
		node.add_child(label_instance)
		if node.facing_right:
			label_instance.scale.x = abs(scale.x) * -1
		label_instance.text = str(amount_changed)
	
	if (amount_changed >= 0):
		label_instance.modulate = heal_color
	else:
		label_instance.modulate = damage_color
