class_name BuyGymUpgrade
extends BaseUpgrade

var spawner: SpawnManager

var show := false


func link_dependencies(tree: SceneTree):
	spawner = tree.root.get_node("/root/Root/GameManager/%Spawner")


func _init():
	id = "buy_gym"
	label = "Buy Shiba Inu Gym"
	description = "Temporarily increases the speed multiplier of shibas who enter (stackable)."
	cost = 200
	max_purchases = 1


func _on_ready():
	pass


func _on_purchase_logic():
	spawner.spawn_building("gym")
	#player_stats.n_current_buildings += 1 currently does nothing until player stats updated


func _should_display_logic() -> bool:
	show = show or player_stats.n_current_inus >= 10
	return show
