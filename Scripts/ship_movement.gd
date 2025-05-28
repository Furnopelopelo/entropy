extends CharacterBody2D

var throttle : float = 0.0
var max_throttle : float = 1.0
var speed_multiplier : int = 10

var speed_limit : float = 600

func _physics_process(delta: float) -> void:
	move_and_slide()


func update()->void:
	throttle = clampf(throttle,0,max_throttle)
	velocity += Vector2.RIGHT.rotated(rotation) * throttle * speed_multiplier
	velocity = velocity.limit_length(600)
	
func brake(delta : float)->void:
	throttle = clampf(throttle,0,max_throttle)
	velocity *= 0.96
