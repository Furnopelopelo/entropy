extends CanvasLayer

@onready var v_box_container: VBoxContainer = $Panel/VBoxContainer
@onready var weight_label: Label = $Panel/WeightLabel
@onready var last_click_timer: Timer = $LastClickTimer

var item : ItemComponent
var inventory_slot : PackedScene = preload("res://Scenes/inventory_ui_panel.tscn")
var inventory_component : InventoryComponent

var last_interacted_item

var selected_item
var item_panel

var selected_item_index

var previous_panel
var style_box

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_K):
		print(v_box_container.get_child(0).get_child(-1).item.name)


func update_panel(update_self : bool = false):
	var text_panel : Panel = item_panel.get_child(3)

	if not previous_panel:
		style_box = text_panel.get_theme_stylebox("panel").duplicate()
		style_box.set("bg_color", Color.AQUAMARINE)
		text_panel.add_theme_stylebox_override("panel", style_box)
		previous_panel = text_panel
	else:
		style_box.set("bg_color", Color(0x1a9ab9ff))
		previous_panel.add_theme_stylebox_override("panel", style_box)
		
		style_box = text_panel.get_theme_stylebox("panel").duplicate()
		style_box.set("bg_color", Color.AQUAMARINE)
		text_panel.add_theme_stylebox_override("panel", style_box)
		previous_panel = text_panel
	
	if update_self:
		style_box.set("bg_color", Color(0x1a9ab9ff))
		previous_panel.add_theme_stylebox_override("panel", style_box)


func add_item(selected_item : Area2D):
	var item_stats = selected_item.item
	
	weight_label.text = "Weight: " + str(inventory_component.current_weight) + "/" + str(inventory_component.max_weight)
	
	var instance = inventory_slot.instantiate()
	instance.get_child(1).text = item_stats.name
	instance.get_child(2).get_child(0).texture = item_stats.texture
	instance.get_child(-1).item = selected_item.item
	
	v_box_container.add_child(instance)


func remove_item(index : int):
	weight_label.text = "Weight: " + str(inventory_component.current_weight) + "/" + str(inventory_component.max_weight)
	v_box_container.get_child(index).queue_free()


func show_menu(item_to_show : ItemComponent):
	$"/root/Lobby/PopupMenu".show_inventory_menu(item_to_show, get_viewport().get_mouse_position())


func _on_v_box_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.position.y < 0:
			return
		var index = event.position.y / 41
		var floor_index = floor(index)
		
		if index - floor_index < 0.85 && floor_index <= inventory_component.item_count - 1:
			item_panel = v_box_container.get_child(floor_index)
			selected_item = item_panel.get_child(-1)
			var item = selected_item.item
			selected_item_index = floor_index
			
			if not last_click_timer.is_stopped() && event.is_action_pressed("shoot"):
				$"/root/Lobby/Player".equip_item(item)
			last_click_timer.start()
			
			if event.button_index == MOUSE_BUTTON_RIGHT:
				show_menu(item)
