extends PopupMenu

@onready var player_inventory = get_tree().root.get_node("Lobby/Player/InventoryComponent")
@onready var player_inventory_ui = get_tree().root.get_node("Lobby/InventoryUI")
@onready var player = get_tree().root.get_node("Lobby/Player")

var selected_item : Area2D
var selected_item_res : ItemComponent

var corpse : Corpse

var index

enum options {
	SELECTOR = 0,
	EQUIP = 1,
	UNEQUIP = 2,
	INSPECT = 3,
	PICKUP = 4,
	DRAG = 5,
	STOPDRAGGING = 6,
	DROP = 7
}

func show_menu(ground_item : Area2D, position):
	update_menu()
	
	var item : ItemComponent = ground_item.item
	selected_item = ground_item
	
	add_separator(item.name)
	add_item("Pick Up", options.PICKUP)
	
	set_position(position)
	popup()
	visible = true

func show_inventory_menu(item : ItemComponent, position):
	update_menu()
	
	selected_item_res = item
	
	add_separator(item.name)
	if player.equipped_item_index == player_inventory_ui.selected_item_index:
		add_item("Unequip", options.UNEQUIP)
	else:
		add_item("Equip", options.EQUIP)
	
	add_item("Drop", options.DROP)
	
	set_position(position)
	popup()
	visible = true

func show_corpse_menu(_corpse, position):
	update_menu()
	
	corpse = _corpse
	var corpse_data = _corpse.item
	
	add_separator(corpse_data.name)
	
	if not corpse.is_dragged:
		add_item("Drag", options.DRAG)
	else:
		add_item("Stop Dragging", options.STOPDRAGGING)
	
	set_position(position)
	popup()
	visible = true

func _process(delta: float) -> void:
	#Sprawdzanie czy można się interaktować gdy jest sie za daleko tego typu
	if selected_item:
		if selected_item.position.distance_to($"/root/Lobby/Player".position) > 40:
			for item in range(item_count):
				set_item_disabled(item, true)
		else:
			for item in range(item_count):
				set_item_disabled(item, false)

func _on_id_pressed(id: int) -> void:
	match id:
		options.PICKUP:
			player_inventory.add_item_to_inventory(selected_item)
			selected_item.queue_free()
			selected_item = null
				
		options.DROP:
			$"/root/Lobby/Player".drop_item(selected_item_res)
			
		options.EQUIP:
			$"/root/Lobby/Player".equip_item(selected_item_res)
		
		options.UNEQUIP:
			$"/root/Lobby/Player".unequip_item()
		
		options.DRAG:
			corpse.on_start_dragging()
			
		options.STOPDRAGGING:
			corpse.on_stop_dragging()

func update_menu():
	clear()
	size.y = 5 #By to okienko zawsze było tak duże jak ilość opcji
