class_name FactoryBuilding
extends BaseBuilding


var collision_max: int = 10



func on_body_entered(body: Node2D):
	if body is InuController:
		player_stats.n_treats += 20
	


func choose_open_spot() -> Vector2:
	var placeholder = Vector2(400, 0)
	return placeholder
