class_name SpaceShipUpgrade
extends BaseUpgrade


var root: Node
var ui_canvas: Node
var space_scene_resource: Resource = preload("res://scenes/space_scene.tscn")


func link_dependencies(tree: SceneTree):
	root = tree.root.get_node("/root/Root")
	ui_canvas = tree.root.get_node("/root/Root/UICanvas")


func _init():
	id = "buy_space_ship"
	label = "BUY SPACESHIP"
	description = "Buy a spaceship to finish the game."
	cost = 100000
	max_purchases = 1
	treats_to_unlock = 10000


func _on_purchase_logic():
	var space_scene: Node2D = space_scene_resource.instantiate()
	root.add_child(space_scene)
	root.move_child(space_scene, 3)
	space_scene.global_position = Vector2(1600, 900) / 2
	
	for child in ui_canvas.get_children():
		child.visible = false
	
	for item in ["ItemContainer", "ClickableTreat", "TreatsContainer", "BuildingContainer", "MapBounds"]:
		var node: Node = root.get_node(item)
		root.remove_child(node)
	
	for node in root.get_node("InuContainer").get_children():
		var inu: Inu = node;
		inu.controller.start_floating()
