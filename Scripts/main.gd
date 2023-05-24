extends Node

@onready var world : World = $World

func _ready():
	Input.joy_connection_changed.connect(_on_joy_connection_changed)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		world.add_player("2")

func _on_joy_connection_changed(device, connected):
	if connected:
		world.add_player(device)
	else:
		world.remove_player(device)
