class_name PlayerStats
extends Node


signal treat_count_update
signal current_inu_count_update
signal max_inu_count_update


@export_category("Player Stats")

@export var creature_score: int = 0
	#set(val):
		#creature_score = val
		#update_creature_score_ui()
	#get:
		#return creature_score


@export_category("UI Components")
@export var treats_score_label: Label


@export var max_inu_capacity: int = 5:
	set(val):
		max_inu_capacity = val
		max_inu_count_update.emit(max_inu_capacity)

var n_current_inus: int = 0:
	set(val):
		n_current_inus = val
		current_inu_count_update.emit(n_current_inus)

var n_treats: int = 0:
	set(val):
		n_treats = val
		treat_count_update.emit(n_treats)
		update_treats_ui()


# TODO: make it so that this will compactly represent large numbers, i.e. 1200000 -> 1.2M
func large_num_to_string(num: int):
	return str(num)
	

func update_creature_score_ui():
	#creature_score_label.text = large_num_to_string(creature_score)
	pass
	
	
func update_treats_ui():
	treats_score_label.text = large_num_to_string(n_treats)
