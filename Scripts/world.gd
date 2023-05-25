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


# From @sustainablelab
func add_player(player_index, is_keyboard):
	var player_copy = player_scene.instantiate()
	player_copy.get_node("AnimatedSprite2D").set_modulate(Color.BLUE_VIOLET)
	player_copy.player_id = player_index
	print(player_copy.player_id)
	players.append(player_copy)
	
	if not is_keyboard:
		input_maps.append({
			"ui_right{n}".format({"n":player_index}): Vector2.RIGHT,
			"ui_left{n}".format({"n":player_index}): Vector2.LEFT,
			"ui_up{n}".format({"n":player_index}): Vector2.UP,
			"ui_down{n}".format({"n":player_index}): Vector2.DOWN,
			})
		# Assign the input_map to this player.
		player_copy.ui_inputs = input_maps[player_index]
		
		
		var right_action: String
		var right_action_event: InputEventJoypadMotion

		var left_action: String
		var left_action_event: InputEventJoypadMotion

		var up_action: String
		var up_action_event: InputEventJoypadMotion

		var down_action: String
		var down_action_event: InputEventJoypadMotion

		right_action = "ui_right{n}".format({"n":player_index})
		InputMap.add_action(right_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		right_action_event = InputEventJoypadMotion.new()
		right_action_event.device = player_index
		right_action_event.axis = JOY_AXIS_LEFT_X # <---- horizontal axis
		right_action_event.axis_value =  1.0 # <---- right
		InputMap.action_add_event(right_action, right_action_event)

		left_action = "ui_left{n}".format({"n":player_index})
		InputMap.add_action(left_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		left_action_event = InputEventJoypadMotion.new()
		left_action_event.device = player_index
		left_action_event.axis = JOY_AXIS_LEFT_X # <---- horizontal axis
		left_action_event.axis_value = -1.0 # <---- left
		InputMap.action_add_event(left_action, left_action_event)

		up_action = "ui_up{n}".format({"n":player_index})
		InputMap.add_action(up_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		up_action_event = InputEventJoypadMotion.new()
		up_action_event.device = player_index
		up_action_event.axis = JOY_AXIS_LEFT_Y # <---- vertical axis
		up_action_event.axis_value = -1.0 # <---- up
		InputMap.action_add_event(up_action, up_action_event)

		down_action = "ui_down{n}".format({"n":player_index})
		InputMap.add_action(down_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		down_action_event = InputEventJoypadMotion.new()
		down_action_event.device = player_index
		down_action_event.axis = JOY_AXIS_LEFT_Y # <---- vertical axis
		down_action_event.axis_value =  1.0 # <---- down
		InputMap.action_add_event(down_action, down_action_event)
	else:
		# Use keyboard
		# Map to keys for four people on one keyboard.
		var arrows: Dictionary = {
			"key_right": KEY_RIGHT,
			"key_left":  KEY_LEFT,
			"key_up":    KEY_UP,
			"key_down":  KEY_DOWN,
			}
		var wasd: Dictionary = {
			"key_right": KEY_D,
			"key_left":  KEY_A,
			"key_up":    KEY_W,
			"key_down":  KEY_S,
			}
		var hjkl: Dictionary = {
			"key_right": KEY_L,
			"key_left":  KEY_H,
			"key_up":    KEY_K,
			"key_down":  KEY_J,
			}
		var uiop: Dictionary = {
			"key_right": KEY_P,
			"key_left":  KEY_U,
			"key_up":    KEY_O,
			"key_down":  KEY_I,
			}
		var keymaps: Dictionary = {
			0: arrows,
			1: wasd,
			2: hjkl,
			3: uiop,
			}

		var right_action: String
		var right_action_event: InputEventKey

		var left_action: String
		var left_action_event: InputEventKey

		var up_action: String
		var up_action_event: InputEventKey

		var down_action: String
		var down_action_event: InputEventKey

		right_action = "ui_right{n}".format({"n":player_index})
		InputMap.add_action(right_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		right_action_event = InputEventKey.new()
		right_action_event.keycode = keymaps[player_index]["key_right"]
		InputMap.action_add_event(right_action, right_action_event)

		left_action = "ui_left{n}".format({"n":player_index})
		InputMap.add_action(left_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		left_action_event = InputEventKey.new()
		left_action_event.keycode = keymaps[player_index]["key_left"]
		InputMap.action_add_event(left_action, left_action_event)

		up_action = "ui_up{n}".format({"n":player_index})
		InputMap.add_action(up_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		up_action_event = InputEventKey.new()
		up_action_event.keycode = keymaps[player_index]["key_up"]
		InputMap.action_add_event(up_action, up_action_event)

		down_action = "ui_down{n}".format({"n":player_index})
		InputMap.add_action(down_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		down_action_event = InputEventKey.new()
		down_action_event.keycode = keymaps[player_index]["key_down"]
		InputMap.action_add_event(down_action, down_action_event)
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
		
