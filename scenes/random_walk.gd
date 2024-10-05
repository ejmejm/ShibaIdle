extends CharacterBody2D


@export var should_walk: bool = true
@export var stop_duration_range: Vector2 = Vector2(1, 3) # Range for random stop duration
@export var bounding_box_shape: CollisionShape2D # CollisionShape2D used for bounding box


var target_position: Vector2
var is_stopping: bool = false
var bounding_box: Rect2
var player_stats: PlayerStats


func _ready():
	print("READY INU")
	# If bounding_box_shape is not assigned, try to find it in the scene tree
	if bounding_box_shape == null:
		bounding_box_shape = $"/root/Root/NavigableArea/CollisionShape2D"
		
		if bounding_box_shape == null:
			push_error("No default CollisionShape2D found, please assign one manually.")
			return

	# Extract bounding box Rect2 from the CollisionShape2D's RectangleShape2D
	if bounding_box_shape and bounding_box_shape.shape is RectangleShape2D:
		var rect_shape: RectangleShape2D = bounding_box_shape.shape as RectangleShape2D
		bounding_box = Rect2(bounding_box_shape.global_position - rect_shape.extents, rect_shape.extents * 2)
	else:
		push_error("Bounding box shape must be a RectangleShape2D!")
	
	

	set_physics_process(should_walk)


func _physics_process(delta):
	if should_walk and not is_stopping:
		# If no target, pick a random spot in the bounding box
		if target_position == Vector2.ZERO:
			target_position = choose_random_spot()

		# Move towards target position
		move_towards_target()

		# Check if reached target or collided
		if global_position.distance_to(target_position) < 5 or is_on_wall():
			stop_movement()


func choose_random_spot() -> Vector2:
	# Pick a random point within the bounding box
	return bounding_box.position + Vector2(
		randi() % int(bounding_box.size.x),
		randi() % int(bounding_box.size.y)
	)


func move_towards_target():
	# Move towards the target position with constant speed
	var direction = (target_position - global_position).normalized()
	velocity = direction * 100  # Adjust speed as needed
	move_and_slide()


func stop_movement():
	velocity = Vector2.ZERO
	target_position = Vector2.ZERO
	is_stopping = true
	var stop_duration = randf_range(stop_duration_range.x, stop_duration_range.y)
	await get_tree().create_timer(stop_duration).timeout
	is_stopping = false
