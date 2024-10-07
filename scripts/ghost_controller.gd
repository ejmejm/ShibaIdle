class_name GhostInuController
extends InuController


func _on_ball_rolled(location: Vector2, radius: float):
	pass


func stop_movement():
	target_position = choose_random_spot()
