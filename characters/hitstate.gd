extends state

class_name hitState

@export var damageable : damageable
@export var character_state_machine : characterStateMachine
@export var dead_state : state
@export var dead_animation_node : String = "dead"
@export var knockback_speed : Vector2 = Vector2(100,0)
@export var return_state : state

@onready var timer : Timer = $Timer

func _ready():
	damageable.connect("on_hit", on_damageable_hit)
	
func on_enter():
	timer.start()

func on_damageable_hit(node : Node, damage_amount : int, knockback_direction : Vector2):
	if (damageable.health > 0):
		character.velocity = knockback_speed * knockback_direction
		emit_signal("interrupt_state", self)
	else: 
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation_node)
	pass
	
func on_exit():
	character.velocity = Vector2.ZERO
	
func _on_timer_timeout():
	next_state = return_state
