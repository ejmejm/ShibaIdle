class_name BuyBigBallUpgrade
extends BaseUpgrade


var container: Node2D


func link_dependencies(tree: SceneTree):
	container = tree.root.get_node("/root/Root/ItemContainer/")


func _init():
	id = "buy_big_ball"
	label = "Upgrade Ball"
	description = "Increases the size of the ball and attracts shibas from farther away."
	cost = 400
	max_purchases = 1
	treats_to_unlock = 250


func _on_purchase_logic():
	#ball.visible = true
	var ball: Node2D = container.get_node("Ball")
	var ball_controller: BallController = ball.get_child(0)
	ball_controller.attraction_radius *= 2
	
	for child in ball_controller.get_children():
		child.scale *= 1.5


func _should_display_logic():
	return player_stats.upgrade_purchases.has("buy_ball") \
		and player_stats.upgrade_purchases.get("buy_ball") >= 1
