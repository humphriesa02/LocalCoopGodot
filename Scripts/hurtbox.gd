class_name Hurtbox
extends Area2D

func _init():
	collision_layer = 0
	collision_mask = 2

func _ready():
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(hitbox: Hitbox) -> void:
	if hitbox == null:
		return
	if str(owner.player_id) != str(hitbox.owner.player_id):
		if owner.has_method("take_damage"):
			owner.take_damage(hitbox.damage)
