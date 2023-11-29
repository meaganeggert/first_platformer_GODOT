extends Control

class_name transitions

@onready var animation_tex : TextureRect = $TextureRect
@onready var animation_player : AnimationPlayer = $AnimationPlayer

@export var scene_switch_anim : String = "fade_out"
@export var scene_to_load : PackedScene

@export var thePlayer : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tex.visible = false

func set_next_animation(fading_out : bool):
	if(fading_out):
		print_debug("fade_out")
		animation_player.queue("fade_out")
	else:
		print_debug("fade_in")
		animation_player.queue("fade_in")
