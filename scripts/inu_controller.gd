class_name InuController
extends CharacterBody2D


const PLAYER_STATS_PATH: String = "/root/Root/GameManager/PlayerStats"
const BOUNDING_BOX_PATH: String = "/root/Root/NavigableArea/CollisionShape2D"
const BALL_PATH: String = "/root/Root/ItemContainer/%Ball"
const TARGET_EQ_THRESHOLD: int = 5

@export var should_walk: bool = true
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


func _ready():
	input_pickable = true
	
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


func _physics_process(delta):
	if should_walk and not is_stopping:
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
