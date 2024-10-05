extends Node

@export_group("External Nodes")
@export var spawn_container: Node
@export var player_stats: PlayerStats


static var INU_RESOURCES := {
	"shiba_inu": preload("res://scenes/shiba_inu.tscn")
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
