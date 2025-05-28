extends Node

var ship : Node2D



func _ready() -> void:
	ship = $"../../Ship"

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("WalkUp"):
		ship.throttle += 0.2 * delta
		ship.update()
	elif Input.is_action_pressed("WalkDown"):
		ship.throttle -= 0.35 * delta
		ship.brake(delta)
	if Input.is_action_pressed("WalkLeft"):
		ship.rotation -= PI * delta
	elif Input.is_action_pressed("WalkRight"):
		ship.rotation += PI * delta
		
	
	$"../../Camera2D".position = ship.position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed: return
		if event.button_index == 4:
			ship.max_throttle += 0.05
		elif event.button_index == 5:
			ship.max_throttle -= 0.05
			
		ship.max_throttle = clampf(ship.max_throttle,0.0,1.0)
