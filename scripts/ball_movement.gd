class_name BallController
extends RigidBody2D


signal rolled


var ball_resource := preload("res://scenes/ball.tscn")
#var roll_sound: AudioStreamPlayer2D = 

var initial_position: Vector2
var follow_cursor := false
var last_mouse_position := Vector2.ZERO
var time_since_release := 0.0
var attraction_radius := 150.0


func _ready() -> void:
	initial_position = get_parent().position


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ResetKey") and get_parent().visible:
		replace_with_copy()


func replace_with_copy() -> void:
	var new_ball = ball_resource.instantiate()
	new_ball.position = initial_position
	
	var old_ball = get_parent()
	
	var controller: BallController = new_ball.get_child(0)
	controller.attraction_radius = attraction_radius
	
	for i in range(len(controller.get_children())):
		controller.get_child(i).scale = get_child(i).scale
	
	var container: Node = old_ball.get_parent()
	container.remove_child(old_ball)
	container.add_child(new_ball)
	old_ball.queue_free()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("PrimaryClick"):
		follow_cursor = true
		last_mouse_position = get_global_mouse_position()
		time_since_release = 0.1
		$"../SelectSound".play()


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
