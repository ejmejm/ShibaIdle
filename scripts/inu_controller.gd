class_name InuController
extends CharacterBody2D


const PLAYER_STATS_PATH: String = "/root/Root/GameManager/PlayerStats"
const BOUNDING_BOX_PATH: String = "/root/Root/NavigableArea/CollisionShape2D"
const BALL_PATH: String = "/root/Root/ItemContainer/%Ball"
const TARGET_EQ_THRESHOLD: int = 5

@export var should_walk: bool = true
@export var floating: bool = false
@export var stop_duration_range: Vector2 = Vector2(1, 3) # Range for random stop duration
@export var bounding_box_shape: CollisionShape2D # CollisionShape2D used for bounding box

var target_position: Vector2
var is_stopping: bool = false
var bounding_box: Rect2
var ball: BallController
var player_stats: PlayerStats
@onready var animated_sprite: AnimatedSprite2D = $ShibaSprite
@onready var sprite: Sprite2D = $ShibaSpriteStationary
@onready var inu_stats: InuStats = %InuStats

var is_mouse_entered: bool = false
var floating_speed: float = 30.0  # Adjust this value to change the floating speed
var floating_angle: float  # Store the random floating angle
var floating_rotation: float  # Store the random floating angle

var hit_player: AudioStreamPlayer


func _ready():
	input_pickable = true
	
	var audio_container = get_node("/root/Root/HitAudioContainer")
	var n_children := len(audio_container.get_children())
	hit_player = audio_container.get_child(randi() % n_children)
	
	# Get player stats so that inu can increase score on collision
	player_stats = get_node(PLAYER_STATS_PATH) 
	if player_stats == null:
		push_error("PlayerStats could not be found!")
		
	# Connect ball movement signal
	var ball_parent: Node = get_node(BALL_PATH)
	ball = ball_parent.get_child(0)
	ball.rolled.connect(_on_ball_rolled)
		
	# If bounding_box_shape is not assigned, try to find it in the scene tree
	if bounding_box_shape == null:
		bounding_box_shape = get_node_or_null(BOUNDING_BOX_PATH)
		if bounding_box_shape == null:
			push_error("No default CollisionShape2D found, please assign one manually.")

	# Extract bounding box Rect2 from the CollisionShape2D's RectangleShape2D
	if bounding_box_shape and bounding_box_shape.shape is RectangleShape2D:
		var rect_shape: RectangleShape2D = bounding_box_shape.shape as RectangleShape2D
		bounding_box = Rect2(bounding_box_shape.global_position - rect_shape.extents, rect_shape.extents * 2)
	else:
		push_error("Bounding box shape must be a RectangleShape2D!")

	set_physics_process(should_walk)
	animated_sprite.play()


func _on_ball_rolled(location: Vector2, radius: float):
	if (global_position - location).length() < radius:
		is_stopping = false
		target_position = location + Vector2(
		randi_range(0, 40),
		randi_range(0, 40),
	)


func start_floating():
	floating = true
	should_walk = false
	is_stopping = false
	animated_sprite.visible = true
	sprite.visible = false
	
	# Generate a random angle between -20 and 20 degrees
	floating_angle = deg_to_rad(randf_range(-20, 20))
	
	# Set initial velocity with the random angle
	velocity = Vector2(floating_speed, 0).rotated(floating_angle)
	floating_rotation = randf_range(-0.2, 0.2)


func _physics_process(delta):
	if floating:
		# Apply a slight perpendicular force to create a floating effect
		#var perpendicular_velocity = velocity.rotated(PI/2).normalized() * sin(Time.get_ticks_msec() * 0.005) * 20
		#velocity = velocity.normalized() * floating_speed + perpendicular_velocity
		move_and_slide()
		
		# Ensure the Inu stays visible and rotates slightly
		#animated_sprite.rotation = floating_rotation
		rotate(delta * floating_rotation)
		
		# Wrap around the screen if the Inu goes off any edge
		if global_position.x > bounding_box.end.x:
			global_position.x = bounding_box.position.x
		elif global_position.x < bounding_box.position.x:
			global_position.x = bounding_box.end.x
		if global_position.y > bounding_box.end.y:
			global_position.y = bounding_box.position.y
		elif global_position.y < bounding_box.position.y:
			global_position.y = bounding_box.end.y
	elif should_walk and not is_stopping:
		# If no target, pick a random spot in the bounding box
		if target_position == Vector2.ZERO:
			target_position = choose_random_spot()

		# Move towards target position
		move_towards_target()

		# Check if reached target or collided
		if global_position.distance_to(target_position) <= TARGET_EQ_THRESHOLD:
			stop_movement()
			
	if velocity.y == 0 and velocity.x == 0:
		animated_sprite.visible = false
		sprite.visible = true

	else:
		animated_sprite.visible = true
		sprite.visible = false


func choose_random_spot() -> Vector2:
	# Pick a random point within the bounding box
	return bounding_box.position + Vector2(
		randi() % int(bounding_box.size.x),
		randi() % int(bounding_box.size.y)
	)


func give_collision_treats(collision: KinematicCollision2D):
	var collider := collision.get_collider()
	if collider is Node2D and (collider as Node2D).get_parent() is CollidableTreat:
		hit_player.play()
		var collidable_treat: CollidableTreat = (collider as Node2D).get_parent()
		var treat_power := (get_parent() as Inu).stats.treat_power
		player_stats.n_treats += treat_power * collidable_treat.treat_give_count


func move_towards_target():
	# Move towards the target position with constant speed
	var direction = (target_position - global_position).normalized()
	velocity = direction * 100 * inu_stats.speed # Adjust speed as needed
	move_and_slide()
	
	#determine direction inu should face
	if velocity.x > 0:
		animated_sprite.flip_v = 0
		animated_sprite.rotation = velocity.angle()
	else:
		animated_sprite.flip_v = 1
		animated_sprite.rotation = velocity.angle()
	
	if get_slide_collision_count() > 0:
		stop_movement()
		var collision := get_slide_collision(0)
		give_collision_treats(collision)


func stop_movement():
	velocity = Vector2.ZERO
	target_position = Vector2.ZERO
	is_stopping = true
	var stop_duration = randf_range(stop_duration_range.x, stop_duration_range.y)
	stop_duration /= inu_stats.speed
	await get_tree().create_timer(stop_duration).timeout
	is_stopping = false


### Handle Deletion ###


func _mouse_enter() -> void:
	is_mouse_entered = true
	

func _mouse_exit() -> void:
	is_mouse_entered = false


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_handle_hover(event)
	elif event is InputEventMouseButton and event.is_action_pressed("PrimaryClick"):
		_handle_click(event)


func _turn_red():
	modulate = Color.RED


func _reverse_red():
	modulate = Color.WHITE


func _handle_hover(event: InputEventMouseMotion) -> void:
	if Input.is_key_pressed(KEY_ALT):
		var mouse_position = get_global_mouse_position()
		if is_mouse_entered:
			_turn_red()
		else:
			_reverse_red()
	else:
		_reverse_red()
		#if get_node("CollisionShape2D").shape.collide_point(to_local(mouse_position)):
			#outline.show()
		#else:
			#outline.hide()
	#else:
		#outline.hide()


func _handle_click(event: InputEventMouseButton) -> void:
	if Input.is_key_pressed(KEY_ALT):
		if is_mouse_entered:
			var inu: Inu = get_parent()
			var container: Node = inu.get_parent()
			container.remove_child(inu)
			inu.queue_free()
			player_stats.n_current_inus -= 1
