class_name BuyBallUpgrade
extends BaseUpgrade


var ball: Node2D


func link_dependencies(tree: SceneTree):
	ball = tree.root.get_node("/root/Root/ItemContainer/%Ball")


func _init():
	id = "buy_ball"
	label = "Buy Ball"
	description = "This ball can be thrown to attract nearby inus."
	cost = 100
	max_purchases = 1
	treats_to_unlock = 40


func _on_purchase_logic():
	ball.visible = true
