class_name World
extends Node

@export var num_players : int = 0
var players : Array = []
var input_maps : Array = []
@onready var player_scene0 = preload("res://Scenes/Player/player.tscn")
@onready var player_scene1 = preload("res://Scenes/Player/player1.tscn")


func add_player(player_index):
	var player_copy = player_scene0.instantiate()
	if player_index == "1":
		player_copy = player_scene1.instantiate()
	player_copy.player_id = player_index
	print(player_copy.player_id)
	players.append(player_copy)
	add_child(player_copy)
	
func remove_player(player_index):
	pass
	
