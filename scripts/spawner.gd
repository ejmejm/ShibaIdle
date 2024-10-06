class_name SpawnManager
extends Node


@onready var spawn_container: Node = %InuContainer
@onready var player_stats: PlayerStats = %PlayerStats


static var INU_RESOURCES := {
	"base_shiba_inu": preload("res://inus/shiba_inu.tscn"),
	"double_shiba_inu": preload("res://inus/double_shiba_inu.tscn")
}


func spawn_inu(inu_type: String):
	if !INU_RESOURCES.has(inu_type):
		push_error(
			"Inu type '%s' cannot be spawned because that inu type does not exist" % inu_type)

	var inu: CharacterBody2D = INU_RESOURCES[inu_type].instantiate()
	inu.visible = false
	spawn_container.add_child(inu)
	inu.position = inu.choose_random_spot()
	inu.visible = true
	
	player_stats.creature_score += 1
