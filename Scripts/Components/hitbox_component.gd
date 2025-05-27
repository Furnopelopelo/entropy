class_name HitboxComponent
extends Area2D

@export var health_component: HealthComponent
@export var hit_flash_animation: AnimationPlayer

func damage(attack):
	if health_component:
		if hit_flash_animation:
			hit_flash_animation.play("hit_flash")
		health_component.damage(attack)
