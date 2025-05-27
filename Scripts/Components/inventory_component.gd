class_name InventoryComponent
extends Node

@onready var inventory_ui = $"/root/Lobby/InventoryUI"

@export var max_weight = 50
var current_weight = 0

var item_count = 0

var inventory : Array[ItemComponent] = []

func _ready():
	inventory_ui.inventory_component = self

func add_item_to_inventory(selected_item : Area2D):
	inventory.append(selected_item.item)
	current_weight += selected_item.item.weight
	
	inventory_ui.add_item(selected_item)
	inventory_ui.inventory_component = self
	
	item_count += 1

func remove_item_from_inventory(item : ItemComponent, index):
	inventory.remove_at(index)
	current_weight -= item.weight
	
	inventory_ui.remove_item(index)
	inventory_ui.inventory_component = self
	
	item_count -= 1
