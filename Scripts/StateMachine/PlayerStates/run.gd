extends PlayerState

var is_crouching = false

func enter(_msg := {}) -> void:
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	if _msg.has("is_crouching"):
		is_crouching = true
		player.animation_player.play("crouch_run")
	else:
		is_crouching = false
		player.animation_player.play("run")

func physics_update(delta: float) -> void:
	# Notice how we have some code duplication between states. That's inherent to the pattern,
	# although in production, your states will tend to be more complex and duplicate code
	# much more rare.
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
		
	if is_crouching:
		player.animation_player.play("crouch_run")
		player.speed = player.crouch_speed
		if Input.is_action_just_released("down"+str(player.player_id)):
			player.animation_player.play("run")
			player.speed = player.run_speed
			is_crouching = false

	# We move the run-specific input code to the state.
	# A good alternative would be to define a `get_input_direction()` function on the `Player.gd`
	# script to avoid duplicating these lines in every script.
	var input_direction_x = player.get_input_direction()
	player.velocity.x = player.speed * input_direction_x
	player.apply_gravity(delta)
	player.move_and_slide()
	player.flip(input_direction_x)

	if Input.is_action_just_pressed("up"+str(player.player_id)):
		state_machine.transition_to("Air", {do_jump = true})
	elif Input.is_action_just_pressed("down"+str(player.player_id)):
		is_crouching = true
	elif Input.is_action_just_pressed("attack"+str(player.player_id)):
		state_machine.transition_to("Attack", {run = true})
	elif is_equal_approx(player.velocity.x, 0.0):
		if is_crouching:
			state_machine.transition_to("Idle", {is_crouching = true})
		else:
			state_machine.transition_to("Idle")
