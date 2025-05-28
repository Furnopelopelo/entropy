class_name MoveComponent
extends Node

@export var actor: Node2D
@export var speed: int = 5000

var direction: Vector2

func _process(delta):
	actor.velocity += direction * delta * speed
	actor.velocity /= 1.5
	
	actor.move_and_slide()
	$"../../Camera2D".position = actor.position
