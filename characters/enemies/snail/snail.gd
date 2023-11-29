extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree

@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var movement_speed : float = 30.0
@export var hit_state : state

@onready var state_machine : characterStateMachine = $characterStateMachine

var facing_right = false
var currentDirection : Vector2 = starting_move_direction

const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if !$ray_detect_floor.is_colliding() && is_on_floor():
		flip()
	if $ray_detect_wall.is_colliding() && is_on_floor():
		flip()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : Vector2 = currentDirection
	if direction && state_machine.check_if_can_move():
		velocity.x = direction.x * movement_speed
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, movement_speed)

	move_and_slide()

func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		movement_speed = abs(movement_speed)
		currentDirection = Vector2.RIGHT
	else: 
		movement_speed = abs(movement_speed) * -1
		currentDirection - Vector2.LEFT
		

