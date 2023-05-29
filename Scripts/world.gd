extends Node

@export var num_players : int = 0
var players : Array = []
var input_maps : Array = []
@onready var player_scene = preload("res://Scenes/Player/PlayerTemplate/player_template.tscn")
# every time we add a new keyboard player, increment this so the mapping is separate from playercount
# i.e., player 2 doesn't just automatically get a different input mapping
var keyboard_map_index = 0

var color_map = {
	0: Color.RED,
	1: Color.YELLOW,
	2: Color.GREEN,
	3: Color.BLUE
}

# From @sustainablelab
func add_player(player_index, player_device = null, is_keyboard = true):
	var player_copy = player_scene.instantiate()
	player_copy.get_node("AnimatedSprite2D").set_modulate(color_map[player_index])
	player_copy.player_id = player_index
	
	
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
		var up_action_event: InputEventJoypadButton
		var alternate_up_action_event: InputEventJoypadMotion

		var down_action: String
		var down_action_event: InputEventJoypadMotion
		
		var primary_action: String
		var primary_action_event: InputEventJoypadButton

		right_action = "ui_right{n}".format({"n":player_index})
		InputMap.add_action(right_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		right_action_event = InputEventJoypadMotion.new()
		right_action_event.device = player_device
		right_action_event.axis = JOY_AXIS_LEFT_X # <---- horizontal axis
		right_action_event.axis_value =  1.0 # <---- right
		InputMap.action_add_event(right_action, right_action_event)

		left_action = "ui_left{n}".format({"n":player_index})
		InputMap.add_action(left_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		left_action_event = InputEventJoypadMotion.new()
		left_action_event.device = player_device
		left_action_event.axis = JOY_AXIS_LEFT_X # <---- horizontal axis
		left_action_event.axis_value = -1.0 # <---- left
		InputMap.action_add_event(left_action, left_action_event)

		up_action = "ui_up{n}".format({"n":player_index})
		InputMap.add_action(up_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		up_action_event = InputEventJoypadButton.new()
		up_action_event.device = player_device
		up_action_event.button_index = JOY_BUTTON_A
		InputMap.action_add_event(up_action, up_action_event)
		
		alternate_up_action_event = InputEventJoypadMotion.new()
		alternate_up_action_event.device = player_device
		alternate_up_action_event.axis = JOY_AXIS_LEFT_Y
		alternate_up_action_event.axis_value = -1.0
		InputMap.action_add_event(up_action, alternate_up_action_event)
		

		down_action = "ui_down{n}".format({"n":player_index})
		InputMap.add_action(down_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		down_action_event = InputEventJoypadMotion.new()
		down_action_event.device = player_device
		down_action_event.axis = JOY_AXIS_LEFT_Y # <---- vertical axis
		down_action_event.axis_value =  1.0 # <---- down
		InputMap.action_add_event(down_action, down_action_event)
		
		primary_action = "ui_primary_attack{n}".format({"n":player_index})
		InputMap.add_action(primary_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		primary_action_event = InputEventJoypadButton.new()
		primary_action_event.device = player_device
		primary_action_event.button_index = JOY_BUTTON_X # <---- vertical axis
		InputMap.action_add_event(primary_action, primary_action_event)
	else:
		# Use keyboard
		# Map to keys for four people on one keyboard.
		var arrows: Dictionary = {
			"ui_right": KEY_RIGHT,
			"ui_left":  KEY_LEFT,
			"ui_up":    KEY_UP,
			"ui_down":  KEY_DOWN,
			"ui_primary_attack": KEY_SHIFT
			}
		var wasd: Dictionary = {
			"ui_right": KEY_D,
			"ui_left":  KEY_A,
			"ui_up":    KEY_W,
			"ui_down":  KEY_S,
			"ui_primary_attack": KEY_G
			}
		var hjkl: Dictionary = {
			"ui_right": KEY_L,
			"ui_left":  KEY_H,
			"ui_up":    KEY_K,
			"ui_down":  KEY_J,
			"ui_primary_attack": KEY_COLON
			}
		var uiop: Dictionary = {
			"ui_right": KEY_P,
			"ui_left":  KEY_U,
			"ui_up":    KEY_O,
			"ui_down":  KEY_I,
			"ui_primary_attack": KEY_BRACKETLEFT
			}
		var keymaps: Dictionary = {
			0: arrows,
			1: wasd,
			2: hjkl,
			3: uiop,
			}
		input_maps.append(keymaps[keyboard_map_index])

		var right_action: String
		var right_action_event: InputEventKey

		var left_action: String
		var left_action_event: InputEventKey

		var up_action: String
		var up_action_event: InputEventKey

		var down_action: String
		var down_action_event: InputEventKey
		
		var primary_action: String
		var primary_action_event: InputEventKey

		right_action = "ui_right{n}".format({"n":player_index})
		InputMap.add_action(right_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		right_action_event = InputEventKey.new()
		right_action_event.keycode = keymaps[keyboard_map_index]["ui_right"]
		InputMap.action_add_event(right_action, right_action_event)

		left_action = "ui_left{n}".format({"n":player_index})
		InputMap.add_action(left_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		left_action_event = InputEventKey.new()
		left_action_event.keycode = keymaps[keyboard_map_index]["ui_left"]
		InputMap.action_add_event(left_action, left_action_event)

		up_action = "ui_up{n}".format({"n":player_index})
		InputMap.add_action(up_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		up_action_event = InputEventKey.new()
		up_action_event.keycode = keymaps[keyboard_map_index]["ui_up"]
		InputMap.action_add_event(up_action, up_action_event)

		down_action = "ui_down{n}".format({"n":player_index})
		InputMap.add_action(down_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		down_action_event = InputEventKey.new()
		down_action_event.keycode = keymaps[keyboard_map_index]["ui_down"]
		InputMap.action_add_event(down_action, down_action_event)
		
		primary_action = "ui_primary_attack{n}".format({"n":player_index})
		InputMap.add_action(primary_action)
		# Creat a new InputEvent instance to assign to the InputMap.
		primary_action_event = InputEventKey.new()
		primary_action_event.keycode = keymaps[keyboard_map_index]["ui_primary_attack"]
		InputMap.action_add_event(primary_action, primary_action_event)
		
		keyboard_map_index += 1
	num_players += 1
	players.append(player_copy)
	
	
func remove_player(player_index):
	pass

# To get our players, spawn them here
func spawn_player(player_index, player_spawn):
	var current_player = players[player_index]
	current_player.transform = player_spawn.transform
	return current_player
		
