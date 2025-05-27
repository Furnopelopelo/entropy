extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("Teleport")
	await animated_sprite.animation_finished
	animated_sprite.play("Idle")
