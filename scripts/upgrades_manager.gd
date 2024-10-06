class_name UpgradeManager
extends Node


var UPGRADE_REGISTRAR := {}
@onready var player_stats: PlayerStats = %PlayerStats


func _ready():
	UPGRADE_REGISTRAR = {
		# Inus
		"buy_shiba_inu": preload("res://upgrades/buy_shiba.gd").new(),
		"buy_double_shiba_inu": preload("res://upgrades/buy_double_shiba.gd").new(),
		
		# Buildings
		"gym_upgrade": preload("res://upgrades/gym_upgrade.gd").new(),
		
		# Items
		"buy_ball": preload("res://upgrades/buy_ball.gd").new(),
		
		# Passives
		"inu_capacity_1": preload("res://upgrades/inu_capacity_1.gd").new(),
		"inu_capacity_2": preload("res://upgrades/inu_capacity_2.gd").new(),
		"inu_capacity_3": preload("res://upgrades/inu_capacity_3.gd").new(),
		"inu_capacity_4": preload("res://upgrades/inu_capacity_4.gd").new(),
		"inu_capacity_5": preload("res://upgrades/inu_capacity_5.gd").new(),
		"inu_capacity_6": preload("res://upgrades/inu_capacity_6.gd").new(),
		
		# Debugging (TODO: REMOVE FOR RELEASE!)
		"debug_treats": preload("res://upgrades/debug_treats.gd").new(),
	}

	for upgrade: BaseUpgrade in UPGRADE_REGISTRAR.values():
		upgrade.set_player_stats(player_stats)
		upgrade.link_dependencies(get_tree())


## Returns the upgrades that should be displayed in the upgrade menu
func get_visible_upgrades() -> Array[BaseUpgrade]:
	var visible_upgrades: Array[BaseUpgrade] = []
	
	for upgrade_name in UPGRADE_REGISTRAR:
		var upgrade: BaseUpgrade = UPGRADE_REGISTRAR[upgrade_name]
		if upgrade.should_display():
			visible_upgrades.append(upgrade)
			
	return visible_upgrades
	
	
func get_all_upgrades() -> Array[BaseUpgrade]:
	var upgrades: Array[BaseUpgrade] = []
	for upgrade_name in UPGRADE_REGISTRAR:
		upgrades.append(UPGRADE_REGISTRAR[upgrade_name])
	return upgrades
