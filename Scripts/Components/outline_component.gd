extends Node
class_name OutlineComponent

const WHITE_OUTLINE = preload("res://Shaders/white_outline.gdshader")

@export var actor : Node2D

var shader_material

func _ready() -> void:
	if actor:
		shader_material = ShaderMaterial.new()
		shader_material.shader = WHITE_OUTLINE
		shader_material.resource_local_to_scene = true
		shader_material.set_shader_parameter("outline_color", Vector4(7, 7, 21, 34))
		actor.material = shader_material
