extends Node

@onready var scene_to_load

@onready var player_images : Array = [$GridContainer/TextureRect, $GridContainer/TextureRect2, $GridContainer/TextureRect3, $GridContainer/TextureRect4]
@onready var base_map = "res://Scenes/Maps/world.tscn"

@onready var start_game_label= $"StartGame?"

var devices_ready = []

# Count of how many players in lobby
var player_index = 0
func _ready():
	# register active player start buttons
	var select_action: String
	var select_action_event: InputEventJoypadButton
	# I is equal to device #
	for i in Input.get_connected_joypads().size():
		select_action = "ui_select{n}".format({"n":i})
		InputMap.add_action(select_action)
		select_action_event = InputEventJoypadButton.new()
		select_action_event.device = i
		select_action_event.button_index = JOY_BUTTON_START
		InputMap.action_add_event(select_action, select_action_event)
		devices_ready.append(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_index > 1:
		start_game_label.visible = true
	# Add controller
	for i in Input.get_connected_joypads().size():
		if Input.is_action_just_pressed("ui_select"+str(i)) and player_index <= 1:
			if not devices_ready[i]:
				player_images[player_index].visible = true
				World.add_player(player_index, i, false)
				devices_ready[i] = true
				player_index += 1
		# More than 1 player and one of them presses start
		elif Input.is_action_just_pressed("ui_select"+str(i)) and player_index > 1:
			start_game()
	if Input.is_action_just_pressed("start_key_0"):
		player_images[player_index].visible = true
		World.add_player(player_index)
		player_index += 1
	elif Input.is_action_just_pressed("ui_cancel") and player_index > 1:
		start_game()
		
		

func start_game():
	get_tree().change_scene_to_file(base_map)
