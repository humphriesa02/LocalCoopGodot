extends Node

@onready var world = $World

func _ready():
	Input.joy_connection_changed.connect(_on_joy_connection_changed)


func _on_joy_connection_changed(device, connected):
	if connected:
		world.add_player(device)
	else:
		world.remove_player(device)
