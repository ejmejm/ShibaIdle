class_name BallController
extends RigidBody2D


signal rolled


var follow_cursor := false
var last_mouse_position := Vector2.ZERO
var time_since_release := 0.0
var attraction_radius := 150.0


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("PrimaryClick"):
		follow_cursor = true
		last_mouse_position = get_global_mouse_position()
		time_since_release = 0.1


func check_let_go():
	if Input.is_action_just_released("PrimaryClick"):
		follow_cursor = false


func _process(delta: float) -> void:
	check_let_go()


func _physics_process(delta: float) -> void:
	if follow_cursor:
		linear_damp = 0
		var mouse_position := get_global_mouse_position()
		var direction := (mouse_position - global_position).normalized()
		var distance := global_position.distance_to(mouse_position)
		var target_velocity: Vector2 = direction * min(distance * 10, 4000)
		var new_velocity := linear_velocity.lerp(target_velocity, 0.1)
		var velocity_change = new_velocity - linear_velocity
		var velocity_change_mag = velocity_change.length()
		velocity_change_mag = min(velocity_change_mag, 23)
		linear_velocity += velocity_change.normalized() * velocity_change_mag
		
		last_mouse_position = mouse_position
	else:
		linear_damp = 1.2
		
		# Emit signal every 100ms while rolling
		time_since_release += delta
		if time_since_release >= 0.1 and linear_velocity.length() >= 20:
			emit_signal("rolled", global_position, attraction_radius)
			time_since_release -= 0.1
	
	# Apply angular velocity based on linear velocity
	angular_velocity = linear_velocity.length() * sign(linear_velocity.x) * 0.02
