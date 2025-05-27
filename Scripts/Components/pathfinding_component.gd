class_name PathfindingComponent
extends NavigationAgent2D

@export var actor : CharacterBody2D
@export var move_component : MoveComponent
var target = null

var activated = true

func _physics_process(delta):
	var dir = actor.to_local(get_next_path_position()).normalized()
	move_component.direction = dir
	makepath()

func makepath() -> void:
	if target and activated:
		target_position = target.global_position
