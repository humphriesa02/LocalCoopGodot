extends Node

@onready var scene_to_load

@onready var player_images : Array = [$GridContainer/TextureRect, $GridContainer/TextureRect2, $GridContainer/TextureRect3, $GridContainer/TextureRect4]

@onready var world = $World
var player_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack0"):
		player_images[player_index].visible = true
		world.add_player(player_index)
		player_index += 1
	if Input.is_action_just_pressed("attack1"):
		player_images[player_index].visible = true
		world.add_player(player_index)
		player_index += 1
