extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var avgPos = Vector2.ZERO
	for i in len(PlayerStatsSingleton.players):
		avgPos += PlayerStatsSingleton.players[i].position
	avgPos /= float(len(PlayerStatsSingleton.players))
	position = avgPos
	#Seems to inherit some offset from other code but largely works
