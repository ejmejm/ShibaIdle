class_name GymBuilding
extends BaseBuilding


var collision_max: int = 10


func on_body_entered(body: Node2D):
	if body is InuController:
		var stats: InuStats = body.get_parent().get_node("InuStats")
		stats.speed_bonus = min(stats.speed_bonus + 1, collision_max)


func choose_open_spot() -> Vector2:
	var placeholder = Vector2(-400, 0)
	return placeholder
