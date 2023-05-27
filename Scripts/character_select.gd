extends Node

@onready var scene_to_load

@onready var player_images : Array = [$GridContainer/TextureRect, $GridContainer/TextureRect2, $GridContainer/TextureRect3, $GridContainer/TextureRect4]
@onready var base_map = "res://Scenes/Maps/world.tscn"


var player_index = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Add controller
	if Input.is_action_just_pressed("start_joy0"):
		player_images[player_index].visible = true
		World.add_player(player_index, false)
		player_index += 1
	elif Input.is_action_just_pressed("start_key_0"):
		player_images[player_index].visible = true
		World.add_player(player_index, true)
		player_index += 1
	elif Input.is_action_just_pressed("game_start_joy"):
		get_tree().change_scene_to_file(base_map)
		
		
