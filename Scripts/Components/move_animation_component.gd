extends AnimationPlayer
class_name MoveAnimationComponent

var _current_animation = ""

func play_animation(animation : String):
	if not _current_animation == animation:
		play(animation)
	
	_current_animation = animation
