extends Area2D
class_name InteractionComponent

@export var outline_component : OutlineComponent

var can_interact : bool = false
var is_interacting : bool = false

signal interacting
signal stopped_interacting

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact") && not is_interacting && can_interact:
		emit_signal("interacting")
	elif Input.is_action_just_pressed("Interact") && is_interacting && can_interact:
		emit_signal("stopped_interacting")

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		can_interact = true
		if outline_component:
			outline_component.shader_material.set_shader_parameter("outline_enabled", true)

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		can_interact = false
		if outline_component:
			outline_component.shader_material.set_shader_parameter("outline_enabled", false)
		emit_signal("stopped_interacting")
