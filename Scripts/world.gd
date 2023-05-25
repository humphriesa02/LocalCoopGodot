class_name World
extends Node

@onready var player_spawn_one = $PlayerSpawn
@onready var player_spawn_two = $PlayerSpawn2
@onready var player_spawn_three = $PlayerSpawn3
@onready var player_spawn_four = $PlayerSpawn4

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
	spawn_player(player_index, player_copy)
	
	
func remove_player(player_index):
	pass
	
func spawn_player(player_index, player_copy):
	if player_index == 0:
		player_copy.transform = player_spawn_one.transform
	elif player_index == 1:
		player_copy.transform = player_spawn_two.transform
	elif player_index == 2:
		player_copy.transform = player_spawn_three.transform
	elif player_index == 3:
		player_copy.transform = player_spawn_four.transform
	add_child(player_copy)
		
