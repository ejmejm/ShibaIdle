class_name BaseUpgrade
extends Node


@onready var player_stats: PlayerStats = %PlayerStats

@export var label: String
@export var description: String
@export var cost: int
@export var max_purchases: int = -1 # Maximum, number of times this upgrade can be purchased

var n_purchases: int = 0 # Number of times this upgrade has been purchased so far


func _on_purchase_logic():
	push_error("Must implement custom purchase logic!")


func _is_purchasable_logic() -> bool:
	return true


func _should_display_logic() -> bool:
	return true


func on_purchase():
	n_purchases += 1
	player_stats.n_treats -= cost
	_on_purchase_logic()


func is_purchasable() -> bool:
	var has_stock := (max_purchases < 0 or n_purchases < max_purchases)
	var sufficient_treats := player_stats.n_treats >= cost
	return _is_purchasable_logic() and has_stock and sufficient_treats


func should_display() -> bool:
	var has_stock := (max_purchases < 0 or n_purchases < max_purchases)
	return _should_display_logic() and has_stock
