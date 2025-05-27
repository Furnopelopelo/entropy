extends CharacterBody2D

@onready var path_finding_target = get_tree().root.get_node("Lobby/Player")

@onready var move_component: MoveComponent = $MoveComponent
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var pathfinding_component: PathfindingComponent = $PathfindingComponent

var timer : int = 0


func _physics_process(_delta: float) -> void:
	timer += 1
	if timer < 10:
		return
	timer = 0
	
	pathfinding_component.target = path_finding_target
	var angle = move_component.direction.angle()
	
	if angle > -(PI / 4) && angle < (PI / 4):
		animated_sprite.play("Right")
	if angle > (PI / 4) && angle < (3 * PI / 4):
		animated_sprite.play("Front")
	if angle > (3 * PI / 4) || angle < -(3 * PI / 4):
		animated_sprite.play("Left")
	if angle > -(3 * PI / 4) && angle < -(PI / 4):
		animated_sprite.play("Back")
	
	if position.distance_squared_to(path_finding_target.position) < 361:
		move_component.speed = 0
	else:
		move_component.speed = 1000


func _on_health_component_died() -> void:
	var corpse = load("res://Scenes/corpse.tscn").instantiate()
	
	corpse.data = {"id": "robobo", "name": "Robobo", "texture": animated_sprite.sprite_frames.get_frame_texture("Front", 0), "weight": 50, "description": "Robobo"}
	$"/root/Lobby".add_child(corpse)
	corpse.position = position
	corpse.rotation = (randf() - 0.5) * PI
	corpse.corpse_sprite.sprite_frames.add_frame("Corpse", animated_sprite.sprite_frames.get_frame_texture(animated_sprite.animation, 0))
	corpse.get_child(0).position.y = -32/2
	
	queue_free()
