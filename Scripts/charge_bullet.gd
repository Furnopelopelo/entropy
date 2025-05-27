extends CharacterBody2D

@onready var move_component = $MoveComponent
@onready var despawn_timer = $Timer

func _ready():
	despawn_timer.start()

func _on_timer_timeout():
	queue_free()

func _on_hitbox_component_area_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		
		hitbox.damage(20)
		queue_free()
