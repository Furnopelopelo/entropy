extends CharacterBody2D

@onready var despawn_timer = $Timer


var direction : Vector2 = Vector2.ZERO

func _ready():
	despawn_timer.start()

func _on_timer_timeout():
	queue_free()

func in_direction(_rotation:float)->void:
	rotation = _rotation
	direction = Vector2.RIGHT.rotated(rotation)

func _physics_process(delta: float) -> void:
	velocity = direction * 1000.0 * delta
	move_and_slide()

func _on_hitbox_component_area_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		
		hitbox.damage(20)
		queue_free()
