extends StaticBody2D

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var particles: GPUParticles2D = $GPUParticles2D

@onready var ambient_music = get_tree().root.get_child(0).get_node("AmbientMusic")

var is_playing : bool :
	get : return audio_stream_player.playing


func _on_interaction_component_interacting() -> void:
	if not is_playing:
		play_music()
	else:
		particles.emitting = false
		audio_stream_player.stop()
		ambient_music.play()


func _on_audio_stream_player_finished() -> void:
	play_music()

func play_music():
	audio_stream_player.stream = preload("res://Sounds/Music/Entropy OST - Clueless Astronauts.wav")
	audio_stream_player.play()
	particles.emitting = true
		
	ambient_music.stop()
