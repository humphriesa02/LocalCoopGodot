extends PlayerState

var is_crouching = false

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	player.animated_sprite.play("idle")
	player.velocity = Vector2.ZERO
	is_crouching = false


func update(delta: float) -> void:
	# If you have platforms that break when standing on them, you need that check for 
	# the character to fall.
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
		
	if is_crouching:
		player.animated_sprite.play("crouch_idle")
		if Input.is_action_just_released("down"+str(player.player_id)):
			player.animated_sprite.play("idle")
			is_crouching = false

	if Input.is_action_just_pressed("up"+str(player.player_id)):
		# As we'll only have one air state for both jump and fall, we use the `msg` dictionary 
		# to tell the next state that we want to jump.
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_just_pressed("down"+str(player.player_id)):
		is_crouching = true
	elif Input.is_action_just_pressed("attack"+str(player.player_id)):
		state_machine.transition_to("Attack", {idle = true})
	elif Input.is_action_pressed("left"+str(player.player_id)) or Input.is_action_pressed("right"+str(player.player_id)):
		state_machine.transition_to("Run")

func physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.move_and_slide()
