class_name BuyDoubleShibaUpgrade
extends BaseUpgrade


var spawner: SpawnManager
var inu_container: Node
var show := false


func link_dependencies(tree: SceneTree):
	spawner = tree.root.get_node("/root/Root/GameManager/%Spawner")
	inu_container = tree.root.get_node("/root/Root/%InuContainer")


func _init():
	id = "buy_double_shiba_inu"
	label = "Attract Double Shiba"
	description = "Buy a double shiba inu companion to roam around your screen. These give you 4x the treats per hit!"
	cost = 20
	max_purchases = -1


func _on_purchase_logic():
	player_stats.n_current_inus += 1
	spawner.spawn_inu("double_shiba_inu")


func _get_shiba_inus() -> Array[Node]:
	var children := inu_container.get_children()
	var shiba_inus: Array[Node] = []
	for node in children:
		if node.has_meta("inu_type") and node.get_meta("inu_type") == "base_shiba_inu":
			shiba_inus.append(node)
	return shiba_inus


func _should_display_logic() -> bool:
	var shiba_inus: Array[Node] = _get_shiba_inus()
	show = show or shiba_inus.size() >= 4
	return show


func _is_purchasable_logic() -> bool:
	return player_stats.n_current_inus < player_stats.max_inu_capacity
