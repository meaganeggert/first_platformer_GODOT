extends state

class_name groundState

@export var jump_velocity : float = -170.0
@export var airState : state
@export var jump_animation : String = "jump"
@export var attack_state : state
@export var attack_node : String = "attack1"

@onready var buffer_timer : Timer = $Timer

func state_process(delta):
	if(!character.is_on_floor() && buffer_timer.is_stopped()):
		next_state = airState

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
	if (event.is_action_pressed("attack")):
		attack()
		
func jump():
	character.velocity.y = jump_velocity
	next_state = airState
	playback.travel(jump_animation)

func attack():
	next_state = attack_state
	playback.travel(attack_node)
