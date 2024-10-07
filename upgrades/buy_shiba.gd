class_name BuyShibaUpgrade
extends BaseUpgrade


var spawner: SpawnManager


func link_dependencies(tree: SceneTree):
	spawner = tree.root.get_node("/root/Root/GameManager/%Spawner")


func _init():
	id = "buy_shiba_inu"
	label = "Attract Shiba Inu"
	description = "Buy one shiba inu companion to roam around your screen"
	cost = 10
	max_purchases = -1


func _on_purchase_logic():
	spawner.spawn_inu("base_shiba_inu")
	player_stats.n_current_inus += 1


func _is_purchasable_logic() -> bool:
	return player_stats.n_current_inus < player_stats.max_inu_capacity
