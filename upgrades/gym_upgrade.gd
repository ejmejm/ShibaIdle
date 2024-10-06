class_name BuyGymUpgrade
extends BaseUpgrade


var spawner: SpawnManager


func link_dependencies(tree: SceneTree):
	spawner = tree.root.get_node("/root/Root/GameManager/%Spawner")


func _init():
	id = "buy_gym"
	label = "Buy Shiba Inu Gymnasium"
	description = "Buy a gym to help your Inu's with their gainz"
	cost = 50
	max_purchases = 1

func _on_ready():
	pass

func _on_purchase_logic():
	spawner.spawn_building("gym")	
	#player_stats.n_current_buildings += 1 currently does nothing until player stats updated

	
func choose_open_spot() -> Vector2:
	#pick an unclaimed building spot
	#currently placeheld for testing
	var placeholder = Vector2(250,375)
	return placeholder


	
func _should_display_logic() -> bool:
	return true #TODO set as true for testing add logic later


func _is_purchasable_logic() -> bool:
	return true #TODO set as true for testing, add logic later
