class_name BuyFlowerShibaUpgrade
extends BaseUpgrade


var spawner: SpawnManager


func link_dependencies(tree: SceneTree):
	spawner = tree.root.get_node("/root/Root/GameManager/%Spawner")


func _init():
	id = "buy_flower_shiba"
	label = "Attract Flower Shiba"
	description = "Flower shibas occasionally drop treats you can pickup."
	cost = 50
	max_purchases = -1
	treats_to_unlock = 40


func _on_purchase_logic():
	spawner.spawn_inu("flower_shiba")
	player_stats.n_current_inus += 1


func _is_purchasable_logic() -> bool:
	return player_stats.n_current_inus < player_stats.max_inu_capacity
