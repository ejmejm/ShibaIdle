class_name PlayerStats
extends Node

@export_category("Player Stats")

@export var creature_score: int = 0:
	set(val):
		creature_score = val
		update_creature_score_ui()
	get:
		return creature_score
		
@export var n_treats: int = 0:
	set(val):
		n_treats = val
		update_treats_ui()
	get:
		return n_treats

@export_category("UI Components")
@export var creature_score_label: Label
@export var treats_label: Label


# TODO: make it so that this will compactly represent large numbers, i.e. 1200000 -> 1.2M
func large_num_to_string(num: int):
	return str(num)
	

func update_creature_score_ui():
	creature_score_label.text = large_num_to_string(creature_score)
	
	
func update_treats_ui():
	treats_label.text = "Treats: " + large_num_to_string(n_treats)
