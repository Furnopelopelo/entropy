class_name HitFlashComponent
extends AnimationPlayer

@export var actor : AnimatedSprite2D

@export var is_enabled = false

var shader_material = null

func _ready():
	shader_material = actor.material as ShaderMaterial

func _process(delta):
	shader_material.set_shader_parameter("Enabled", is_enabled)
