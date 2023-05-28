extends Node

@onready var world = $World
@onready var player_spawns : Array = [$World/PlayerSpawn, $World/PlayerSpawn2, $World/PlayerSpawn3, $World/PlayerSpawn4]

func _ready():
	Input.joy_connection_changed.connect(_on_joy_connection_changed)
	setup_players()


func _on_joy_connection_changed(device, connected):
	if connected:
		world.add_player(device)
	else:
		world.remove_player(device)
		
func setup_players():
	print(World.num_players)
	for i in World.num_players:
		var player = World.spawn_player(i, player_spawns[i])
		add_child(player)

