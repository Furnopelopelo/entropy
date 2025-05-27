extends StaticBody2D

@onready var mission_control_ui: CanvasLayer = get_tree().root.get_node("Lobby/MissionControlUI")

func _on_interaction_component_interacting() -> void:
	mission_control_ui.visible = true


func _on_interaction_component_stopped_interacting() -> void:
	mission_control_ui.visible = false
