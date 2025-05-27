class_name HealthComponent
extends Node

signal died

@export var max_health: int

var health: int

func _ready():
	health = max_health

func damage(damage: int):
	health -= damage
	if health <= 0:
		died.emit()

func heal(healAmount: int):
	health += healAmount
