class_name Player
extends CharacterBody2D


var speed : float
@export var run_speed : float = 200.0
@export var crouch_speed : float = 125.0
@export var jump_velocity : float = -200.0
@export var full_hop : float = 30.0
@export var min_hop : float = 18.0 
@export var double_jump_velocity: float = -150.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

@export var player_id = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	speed = run_speed


func flip(direction):
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

func get_input_direction():
	var input_direction_x: float = (
		Input.get_action_strength("right"+str(player_id))
		- Input.get_action_strength("left"+str(player_id))
	)
	return input_direction_x
	
func apply_gravity(delta):
	velocity.y += gravity * delta
