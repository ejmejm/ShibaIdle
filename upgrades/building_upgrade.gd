class_name BuyBuildingUpgrade
extends BaseUpgrade

@onready var sprite : Sprite2D = $BuildingSprite
@export var collisions : int =  0
@export var collision_max: int = 1
@export var texture : Texture

func _on_ready():
	sprite.texture = texture
	max_purchases = 1

func _on_purchase_logic():
	pass #implement code here to place a building down
	
func _on_rigid_body_2d_body_entered(body):
	push_error("Implement custom collision logic")
	
