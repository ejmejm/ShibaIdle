class_name BuyGymUpgrade
extends BaseUpgrade

var spawner: SpawnManager


func link_dependencies(tree: SceneTree):
	spawner = tree.root.get_node("/root/Root/GameManager/%Spawner")


func _init():
	id = "buy_gym"
	label = "Buy Shiba Inu Gymnasium"
	description = "Buy a gym to help your Inu's with their gainz"
	cost = 1 #1 for testing
	max_purchases = 1

func _on_ready():
	pass

func _on_purchase_logic():
	spawner.spawn_building("gym")	
	#player_stats.n_current_buildings += 1 currently does nothing until player stats updated

	
func _should_display_logic() -> bool:
	return true #TODO set as true for testing add logic later


func _is_purchasable_logic() -> bool:
	return true #TODO set as true for testing, add logic later
