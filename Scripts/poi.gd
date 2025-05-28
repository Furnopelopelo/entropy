extends Area2D


func _ready() -> void:
	connect("body_entered",_body_entered)
	connect("body_exited",_body_exited)
	
func _physics_process(delta: float) -> void:
	pass
	
	
func _body_entered(body : Node2D)->void:
	var landing_ui : CanvasLayer = $"../POILandingUI"
	landing_ui.get_child(0).get_child(1).connect("button_down",land)
	landing_ui.show()
	

func _body_exited(body:Node2D)->void:
	var landing_ui : CanvasLayer = $"../POILandingUI"
	landing_ui.get_child(0).get_child(1).disconnect("button_down",land)
	landing_ui.hide()


func land()->void:
	$"../POIBackground".show()
	hide()
	$"../Player".interact_with_terminal()
	
	
