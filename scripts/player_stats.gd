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
		treat_update_actions()
	get:
		return n_treats

@export_category("UI Components")
@export var creature_score_label: Label
@export var treats_label: Label


# TODO: Move this somewhere else
const shiba_inu_resource = preload("res://scenes/shiba_inu.tscn")


# TODO: make it so that this will compactly represent large numbers, i.e. 1200000 -> 1.2M
func large_num_to_string(num: int):
	return str(num)
	

func update_creature_score_ui():
	creature_score_label.text = large_num_to_string(creature_score)
	
	
func update_treats_ui():
	treats_label.text = "Treats: " + large_num_to_string(n_treats)


# TODO: Move this function out of player stats
func treat_update_actions():
	# If treats >= 5, spawn a new shiba inu and reset the treats
	# Update the creature score when adding a new shiba inu
	pass
	if n_treats >= 5:
		var inu: CharacterBody2D = shiba_inu_resource.instantiate()
		$"/root/Root".add_child(inu)
		inu.position = inu.choose_random_spot()
		creature_score += 1
		n_treats = 0
	
