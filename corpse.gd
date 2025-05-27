extends Node2D
class_name Corpse

@onready var player = get_tree().root.get_node("Lobby/Player")
@onready var corpse_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hand_sprite: Sprite2D = $HandSprite

var item : ItemComponent

var data : Dictionary

var is_dragged : bool = false
var r = 15


func _physics_process(delta: float) -> void:
	if is_dragged:
		var direction = (position - player.position) * 1.10
		if position.distance_squared_to(player.position) > pow(r, 2):
			position = lerp(position, position - direction, 0.05)


func _ready() -> void:
	item = ItemComponent.new()
	
	item.name = "Dead " + data["name"]
	item.texture = data["texture"]
	item.weight = data["weight"]
	item.description = data["description"]
	item.stacksize = 1


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			$"/root/Lobby/PopupMenu".show_corpse_menu(self, event.position)

func on_start_dragging():
	is_dragged = true
	hand_sprite.visible = true
	$"/root/Lobby/Player".move_component.speed *= (1 - item.weight / 100)

func on_stop_dragging():
	is_dragged = false
	hand_sprite.visible = false
	$"/root/Lobby/Player".move_component.speed /= (1 - item.weight / 100)
