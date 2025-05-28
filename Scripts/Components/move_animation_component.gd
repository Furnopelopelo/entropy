extends AnimationPlayer
class_name MoveAnimationComponent

var _current_animation = ""

var reverting : bool = false

func play_animation(animation : String):
	if not _current_animation == animation:
		play(animation)
	
	_current_animation = animation

func revert_animation()->void:
	$"../AnimatedSprite2D".rotation = lerp_angle($"../AnimatedSprite2D".rotation,0,0.05)
	if abs($"../AnimatedSprite2D".rotation)<0.04:
		$"../AnimatedSprite2D".rotation = 0
		_current_animation = ""
