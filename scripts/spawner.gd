class_name SpawnManager
extends Node


@onready var spawn_container: Node = %InuContainer
@onready var building_container: Node = %BuildingContainer
@onready var player_stats: PlayerStats = %PlayerStats
@onready var spawn_sound = preload("res://audio/ShibaSpawnSound.mp3")
@onready var audiofx: AudioStreamPlayer = $"../../SoundFX"


static var INU_RESOURCES := {
	"base_shiba_inu": preload("res://inus/shiba_inu.tscn"),
	"double_shiba_inu": preload("res://inus/double_shiba_inu.tscn")
}

static var BUILDING_RESOURCES := {
	"gym": preload("res://scenes/gym.tscn"),
	"factory": preload("res://scenes/treatfactory.tscn")
}

func spawn_inu(inu_type: String):
	if !INU_RESOURCES.has(inu_type):
		push_error(
			"Inu type '%s' cannot be spawned because that inu type does not exist" % inu_type)

	var inu: Inu = INU_RESOURCES[inu_type].instantiate()
	inu.visible = false
	spawn_container.add_child(inu)
	var tempos: Vector2 = Vector2(0,0)
	while tempos.x >= -155 and tempos.x <= 155 and tempos.y >= -100 and tempos.y <=100:
		tempos = Vector2(randi() % 2303 - 1151, randi() % 1295 - 647)
	inu.position = tempos
	inu.visible = true
	audiofx.stream = spawn_sound
	audiofx.play()
	
	player_stats.creature_score += 1
	
func spawn_building(building_type: String):
	if !BUILDING_RESOURCES.has(building_type):
		push_error("
		Building type '%s' cannot be spawned because that building does not exist" % building_type)
		
	var building: BaseBuilding = BUILDING_RESOURCES[building_type].instantiate()
	building.visible = false
	building_container.add_child(building)
	building.position = building.choose_open_spot()
	building.visible = true
	
	
