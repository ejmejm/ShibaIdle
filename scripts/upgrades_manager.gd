class_name UpgradeManager
extends Node


var UPGRADE_REGISTRAR := {}
@onready var player_stats: PlayerStats = %PlayerStats


func _ready():
	UPGRADE_REGISTRAR = {
		"buy_shiba_inu": preload("res://upgrades/buy_shiba.gd").new()
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
