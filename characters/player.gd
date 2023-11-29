extends CharacterBody2D

class_name Player

var layer_of_collision = null
const WATER_LAYER = 1 << (4-1)

var timer_ready = true


@export var speed : float = 200.0

@export var transitioner : transitions

@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree

@onready var state_machine : characterStateMachine = $characterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true
	GameManager.player = self

func _physics_process(delta):
	collision.set_deferred("disabled", false)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
#	if !$ray_detect_fall.is_colliding():
#		print_debug("falling")
#	if $ray_detect_water.is_colliding():
#		print_debug("on water")
		
	if !$ray_detect_fall.is_colliding() && $ray_detect_water.is_colliding():
		#print_debug("this is happening")
		collision.set_deferred("disabled", true)
		$fallTimer.start()
	
	if $ray_detect_bonus.is_colliding():
		print_debug("testing")
		transitioner.set_next_animation(true)
		$transitionTimer.start()
		
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if position.y >= 500:
		die()
	
	move_and_slide()
	
	update_animation_parameters()
	update_facing_direction()
	
## FUNCTION DEFINITIONS
	
func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	emit_signal("facing_direction_changed", !sprite.flip_h)

func _on_fall_timer_timeout():
	get_tree().reload_current_scene()
	
func go_to_bonus_level():
	var bonus_level_path = "res://levels/bonus.tscn"
	get_tree().change_scene_to_file(bonus_level_path)
	
func go_to_next_level():
	var current_scene_path = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_path.to_int() + 1
	var next_level_path = "res://levels/level_" + str(next_level_number) + ".tscn"
	get_tree().change_scene_to_file(next_level_path)
	
func die():
	GameManager.respawn_player()

func _on_transition_timer_timeout():
	go_to_bonus_level()
