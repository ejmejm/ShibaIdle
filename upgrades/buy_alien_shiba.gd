class_name BuyAlienShibaUpgrade
extends BaseUpgrade


var spawner: SpawnManager


func link_dependencies(tree: SceneTree):
	spawner = tree.root.get_node("/root/Root/GameManager/%Spawner")


func _init():
	id = "buy_alien_shiba"
	label = "Attract Alien Shiba"
	description = "Alien shibas give 5 treats per hit."
	cost = 100
	max_purchases = -1
	treats_to_unlock = 40


func _on_purchase_logic():
	spawner.spawn_inu("alien_shiba")
	player_stats.n_current_inus += 1


func _should_display_logic() -> bool:
	return player_stats.n_current_inus < player_stats.max_inu_capacity


func _is_purchasable_logic() -> bool:
	return player_stats.n_current_inus < player_stats.max_inu_capacity
