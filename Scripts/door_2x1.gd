extends StaticBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@onready var door_open_sfx: AudioStreamPlayer2D = $DoorOpenSfx
@onready var door_close_sfx: AudioStreamPlayer2D = $DoorCloseSfx

var shader_material = null

var is_opened = false
var can_open = false


func _ready():
	shader_material = animated_sprite.material as ShaderMaterial


func open():
	animated_sprite.play("Open")
	collision_shape.disabled = true
	door_open_sfx.play()


func close():
	animated_sprite.play("Close")
	collision_shape.disabled = false
	door_close_sfx.play()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact") && not is_opened && can_open:
		open()
		is_opened = true
	elif Input.is_action_just_pressed("Interact") && is_opened && can_open:
		close()
		is_opened = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		can_open = true
		shader_material.set_shader_parameter("outline_enabled", true)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		can_open = false
		shader_material.set_shader_parameter("outline_enabled", false)


#func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#print("AAAAAAAAAAA")
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#if can_open:
			#open()
			#is_opened = true
		#else:
			#close()
			#is_opened = false
