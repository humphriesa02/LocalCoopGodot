class_name Hitbox
extends Area2D


@export var damage :float = 10

func _init():
	collision_layer = 2
	collision_mask = 0
