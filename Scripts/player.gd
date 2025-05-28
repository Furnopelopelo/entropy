extends CharacterBody2D
class_name Player

var move_component: MoveComponent
var inventory_component: InventoryComponent
var animated_sprite: AnimatedSprite2D
var inventory_ui: CanvasLayer

var movement_animation: MoveAnimationComponent

var rotation_pivot: Node2D
var hand: Node2D

var direction : Vector2

var health : float = 100

var any_item_equipped = false
var equipped_item_index : int = -1


var ship : CharacterBody2D


var ship_controls : Node


func _ready() -> void:
	inventory_ui = get_tree().root.get_node("Lobby/InventoryUI")
	move_component = $MoveComponent
	ship_controls = $ShipControlComponent
	inventory_component = $InventoryComponent
	animated_sprite = $AnimatedSprite2D
	movement_animation = $MoveAnimationComponent
	rotation_pivot = $RotationPivot
	hand = $RotationPivot/Hand
	ship = $"../Ship"
	
func _physics_process(_delta: float) -> void:
	direction = Input.get_vector("WalkLeft", "WalkRight", "WalkUp", "WalkDown")
	move_component.direction = direction
	
	if move_component.direction.x < 0:
		animated_sprite.play("Left")
		movement_animation.play_animation("Left")
	elif move_component.direction.x > 0:
		animated_sprite.play("Right")
		movement_animation.play_animation("Right")
	else:
		movement_animation.revert_animation()
	if move_component.direction.y > 0:
		animated_sprite.play("Front")
		movement_animation.play_animation("Front")
	elif move_component.direction.y < 0:
		animated_sprite.play("Back")
		movement_animation.play_animation("Front")
	
	#Rotatowanie itemu wyequipowanego tego typu
	rotation_pivot.look_at(get_global_mouse_position())
	if hand.get_child_count() > 0:
		if hand.get_child(0).global_position.x < rotation_pivot.global_position.x:
			hand.get_child(0).get_child(0).flip_v = true
		else:
			hand.get_child(0).get_child(0).flip_v = false

func equip_item(item : ItemComponent):
	var equipped_item = load(item.id).instantiate()
	if any_item_equipped:
		unequip_item()
		
	hand.add_child(equipped_item)
	equipped_item.is_equipped = true
	any_item_equipped = true
	
	equipped_item_index = inventory_ui.selected_item_index
	
	inventory_ui.update_panel()

func unequip_item():
	hand.get_child(0).queue_free()
	any_item_equipped = false
	inventory_ui.update_panel(true)
	equipped_item_index = -1

func drop_item(item):
	var selected_item = load(item.id).instantiate()
	inventory_component.remove_item_from_inventory(item, inventory_ui.selected_item_index)
	$"/root/Lobby".add_child(selected_item)

	selected_item.position = $"/root/Lobby/Player".position
	selected_item.rotation = (randf() - 0.5) * PI
	
	if hand.get_child_count() > 0 && equipped_item_index == inventory_ui.selected_item_index:
		if hand.get_child(0).item.name == item.name:
			unequip_item()

	if inventory_ui.selected_item_index < equipped_item_index:
		equipped_item_index -= 1


func interact_with_terminal()->void:
	if ship.visible:
		ship.hide()
		show()
		$"../ShipInside".show()
		move_component.process_mode = Node.PROCESS_MODE_INHERIT
		ship_controls.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		ship.show()
		hide()
		$"../ShipInside".hide()
		move_component.process_mode = Node.PROCESS_MODE_DISABLED
		ship_controls.process_mode = Node.PROCESS_MODE_INHERIT

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		if hand.get_child_count() > 0:
			hand.get_child(0).shoot(rotation_pivot.rotation)


#$"../CanvasLayer/Label".text = "Entropy Level: " + str(Vector2.ZERO.distance_squared_to(ship.position/1000) / 2500)
