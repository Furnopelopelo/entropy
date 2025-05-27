class_name SpawnerComponent
extends Node2D

@export var scene: PackedScene

func spawn(global_position: Vector2, parent: Node = get_tree().current_scene):
	var instance = scene.instantiate()
	parent.add_child(instance)
	instance.global_position = global_position
	return instance
