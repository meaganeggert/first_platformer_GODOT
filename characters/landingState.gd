extends state

@export var landing_animation_name : String = "landing"
@export var groundState : state

func _on_animation_tree_animation_finished(anim_name):
	if (anim_name == landing_animation_name):
		next_state = groundState
