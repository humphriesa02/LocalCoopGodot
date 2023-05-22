class_name World
extends Node

@export var num_players : int = 0
var players : Array = []
var input_maps : Array = []
@onready var player_scene = preload("res://Scenes/Player/PlayerTemplate/player_template.tscn")


func add_player(player_index):
	var player_copy = player_scene.instantiate()
	player_copy.get_node("AnimatedSprite2D").set_modulate(Color.BLUE_VIOLET)
	player_copy.player_id = player_index
	print(player_copy.player_id)
	players.append(player_copy)
	add_child(player_copy)
	
func remove_player(player_index):
	pass
	
