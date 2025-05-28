extends Node2D

@onready var stars2: Sprite2D = $SpaceBackground/ParallaxLayer2/Sprite2D
@onready var black_hole: Sprite2D = $SpaceBackground/BalckHoleParallaxLayer/Sprite2D

func _physics_process(delta: float) -> void:
	stars2.position.x += 0.01
	stars2.position.y += 0.008
	
	black_hole.rotation += 0.001 * delta
