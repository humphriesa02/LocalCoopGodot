extends PlayerState

var has_double_jumped : bool = false

# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	player.animated_sprite.play("jump_start")
	if msg.has("do_jump"):
		player.velocity.y = player.jump_velocity


func physics_update(delta: float) -> void:
	# Horizontal movement.
	var input_direction_x = player.get_input_direction()
	player.velocity.x = player.speed * input_direction_x
	player.flip(input_direction_x)
	# Vertical movement.
	player.velocity.y += player.gravity * delta
	if player.velocity.y > 0:
		player.animated_sprite.play("fall")
		
	if Input.is_action_just_pressed("up"+str(player.player_id)):
		if not has_double_jumped:
			player.velocity.y = player.double_jump_velocity
			player.animated_sprite.play("double jump")
			has_double_jumped = true
	player.move_and_slide()

	# Landing.
	if player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
			
func exit(_msg := {}) -> void:
	has_double_jumped = false
