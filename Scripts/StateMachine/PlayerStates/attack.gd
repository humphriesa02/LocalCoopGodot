extends PlayerState

var previous_state : String = ""

func enter(msg := {}) -> void:
	player.animated_sprite.connect("animation_finished", transition_to_state)
	if msg.has("idle"):
		previous_state = "Idle"
		player.animated_sprite.play("a_idle_punch")
	elif msg.has("run"):
		previous_state = "Run"
		player.animated_sprite.play("a_run_punch")
		
func physics_update(delta: float) -> void:
	player.velocity = player.velocity.lerp(Vector2.ZERO, 2*delta)
	print(player.velocity)
	player.move_and_slide()
	

func transition_to_state():
	print("Transition back")
	state_machine.transition_to(previous_state)	
	
func exit(msg := {}) -> void:
	player.animated_sprite.disconnect("animation_finished", transition_to_state)

