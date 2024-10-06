extends Sprite2D


@onready var rigid_body: RigidBody2D = $".."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation = -rigid_body.rotation
