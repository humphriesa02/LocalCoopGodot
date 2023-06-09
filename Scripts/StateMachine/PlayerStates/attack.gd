extends PlayerState

var previous_state : String = ""

func enter(msg := {}) -> void:
	player.animation_player.animation_finished.connect(transition_to_state.bind(player.animation_player.current_animation))
	if msg.has("idle"):
		previous_state = "Idle"
		player.animation_player.play("a_idle_punch")
	elif msg.has("run"):
		previous_state = "Run"
		player.animation_player.play("a_run_punch")
		
func physics_update(delta: float) -> void:
	player.velocity = player.velocity.lerp(Vector2.ZERO, 2*delta)
	player.move_and_slide()
	

func transition_to_state(_name, _name2):
	state_machine.transition_to(previous_state)	
	
func exit(msg := {}) -> void:
	player.animation_player.disconnect("animation_finished", transition_to_state)

