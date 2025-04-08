extends Node2D


@export var speed := 0.1

@export var node : Node2D

func _physics_process(delta: float) -> void:
	rotation = rotation + delta * speed
