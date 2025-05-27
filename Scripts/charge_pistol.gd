extends Area2D

@onready var shooting_point: Node2D = $ShootingPoint
@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var firerate_timer: Timer = $FirerateTimer

var item : ItemComponent

var is_equipped = false

func _ready() -> void:
	item = ItemComponent.new()
	
	item.id = "res://Scenes/charge_pistol.tscn"
	item.name = "Charge Pistol"
	item.texture = load("res://Sprites/ChargePistol.png")
	item.weight = 0.8
	item.description = "Pistol"
	item.is_equipable = true
	
func shoot(_rotation):
	#if not firerate_timer.is_stopped():
		#return
	#firerate_timer.start()
	
	var shooted_bullet = spawner_component.spawn(shooting_point.global_position)
	shooted_bullet.rotation = get_parent().rotation
	shooted_bullet.move_component.direction = Vector2.RIGHT.rotated(_rotation)
	shooted_bullet.rotation = _rotation

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_RIGHT && not is_equipped:
			$"/root/Lobby/PopupMenu".show_menu(self, event.position)
