extends PlayerState

var has_double_jumped : bool = false
var can_double_jump : bool = false
var initial_jump_height: float
var initial_jump_frames: int = 5
var frames_count: int = 0
var jump_button_pressed: bool = false
var jump_button_press_time: float = 0
var max_jump_press_time: float = 0.3
var max_jump_scale: float = 100
var has_jumped : bool
var descent_modifier : float = 0
var max_descent_modifier : float = 8

# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	frames_count = 0
	initial_jump_height = player.min_hop
	player.velocity.y = 0
	can_double_jump = false
	descent_modifier = 0
	player.animation_player.play("jump_start")
	if msg.has("do_jump"):
		has_jumped = true
		jump_button_pressed = true
		jump_button_press_time = 0
	else:
		has_jumped = false


func physics_update(delta: float) -> void:
	
	# Horizontal movement.
	var input_direction_x = player.get_input_direction()
	player.velocity.x = player.speed * input_direction_x
	player.flip()
	
	if has_jumped:
		# handle jumping logic
		
		# if player still pressing up in "Air" state, keep track of how long
		if Input.is_action_just_pressed("ui_up" + str(player.player_id)):
			jump_button_pressed = true
			jump_button_press_time = 0
		# when player releases the jump button, take note
		elif Input.is_action_just_released("ui_up" + str(player.player_id)):
			jump_button_pressed = false
			if not has_double_jumped:
				can_double_jump = true
		
		# increase held button time
		if jump_button_pressed:
			jump_button_press_time += delta
			if jump_button_press_time > max_jump_press_time:
				jump_button_press_time = max_jump_press_time
		
		# calculate a jump scale based on how long the player held the button
		var jump_scale = ((jump_button_press_time / max_jump_press_time) * max_jump_scale)
		
		# Vertical movement
		if frames_count < initial_jump_frames:
			# Initial jump height calculation
			player.velocity.y = -initial_jump_height * jump_scale
			initial_jump_height -= (initial_jump_height / initial_jump_frames)
			frames_count += 1
		else:
			# Normal jump behavior
			player.velocity.y += player.gravity * delta + descent_modifier
	
	else:
		# handle falling logic
		player.velocity.y += player.gravity * delta + descent_modifier
	if player.velocity.y > 0:
			if has_double_jumped:
				player.animation_player.play("double_jump_fall")
			else:	
				player.animation_player.play("fall")
			
	if Input.is_action_just_pressed("ui_up"+str(player.player_id)):
		if not has_double_jumped:
			if has_jumped and can_double_jump:
				player.velocity.y = player.double_jump_velocity
				player.animation_player.play("double jump")
				has_double_jumped = true
			elif not has_jumped:
				player.velocity.y = player.double_jump_velocity
				player.animation_player.play("double jump")
				has_double_jumped = true
	elif Input.is_action_pressed("ui_primary_attack"+str(player.player_id)):
		player.animation_player.play("a_air")
	elif Input.is_action_pressed("ui_down"+str(player.player_id)):
		if descent_modifier < max_descent_modifier:
			descent_modifier += 1
			
	player.move_and_slide()

	# Landing.
	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
			
func exit(_msg := {}) -> void:
	has_double_jumped = false
