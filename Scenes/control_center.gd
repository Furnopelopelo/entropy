extends StaticBody2D

func _on_interaction_component_interacting() -> void:
	$"/root/Lobby/Player".interact_with_terminal()

func _on_interaction_component_stopped_interacting() -> void:
	if $"/root/Lobby/MissionControlUI".visible:
		$"/root/Lobby/Player".interact_with_terminal()
