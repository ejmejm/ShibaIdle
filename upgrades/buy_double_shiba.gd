class_name BuyDoubleShibaUpgrade
extends BaseUpgrade


var spawner: SpawnManager
var inu_container: Node


func link_dependencies(tree: SceneTree):
	spawner = tree.root.get_node("/root/Root/GameManager/%Spawner")
	inu_container = tree.root.get_node("/root/Root/%InuContainer")


func _init():
	id = "buy_double_shiba_inu"
	label = "Attract Double Shiba Inu"
	description = "Buy a double shiba inu companion to roam around your screen. Requires 2 shiba inus."
	cost = 30
	max_purchases = -1


func _on_purchase_logic():
	spawner.spawn_inu("double_shiba_inu")
	var shiba_inus := _get_shiba_inus()
	for i in 2:
		inu_container.remove_child(shiba_inus[i])
		shiba_inus[i].queue_free()
	player_stats.n_current_inus -= 1


func _get_shiba_inus() -> Array[Node]:
	var children := inu_container.get_children()
	var shiba_inus: Array[Node] = []
	for node in children:
		if node.has_meta("inu_type") and node.get_meta("inu_type") == "base_shiba_inu":
			shiba_inus.append(node)
	return shiba_inus


func _should_display_logic() -> bool:
	var shiba_inus: Array[Node] = _get_shiba_inus()
	return shiba_inus.size() >= 2
