class_name BuyFactoryUpgrade
extends BaseUpgrade

var spawner: SpawnManager


var show := false


func link_dependencies(tree: SceneTree):
	spawner = tree.root.get_node("/root/Root/GameManager/%Spawner")


func _init():
	id = "buy_factory"
	label = "Buy Treat Factory"
	description = "Walking through this gives exactly 20 treats for all shibas."
	cost = 3000
	max_purchases = 1


func _on_ready():
	pass


func _on_purchase_logic():
	spawner.spawn_building("factory")
	#player_stats.n_current_buildings += 1 currently does nothing until player stats updated


func _should_display_logic() -> bool:
	show = show or player_stats.n_current_inus >= 20
	return show
