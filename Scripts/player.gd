class_name Player
extends CharacterBody2D


var speed : float
@export var walk_speed : float = 100.0
@export var run_speed : float = 200.0
@export var crouch_speed : float = 125.0
@export var jump_velocity : float = -200.0
@export var full_hop : float = 30.0
@export var min_hop : float = 18.0 
@export var double_jump_velocity: float = -150.0
@export var health = 5

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var state_machine : StateMachine = $StateMachine

@export var player_id = 0

var current_dir

var dirs = { "right": 0,  "left": 1 }

var ui_inputs = {}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	speed = walk_speed
	current_dir = dirs.right


func flip(direction):
	if velocity.x > 0:
		if current_dir == dirs.left:
			current_dir = dirs.right
			scale.x = -1

	elif velocity.x < 0:
		if current_dir == dirs.right:
			current_dir = dirs.left
			scale.x = -1

func get_input_direction():
	var input_direction_x: float = (
		Input.get_action_strength("ui_right"+str(player_id))
		- Input.get_action_strength("ui_left"+str(player_id))
	)
	return input_direction_x
	
func apply_gravity(delta):
	velocity.y += gravity * delta
	
func take_damage(amount: int) -> void:
	state_machine.transition_to("Damage")
	health -= amount
