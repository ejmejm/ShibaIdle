extends RigidBody2D
#put the logic here to determine impact on a building
var collisions : int =  0
var collision_max: int = 10
var texture : Texture

func _ready():
	pass

func _on_rigid_body_2d_body_entered(body):
	collisions += 1
	if collisions >= 10:
		print("yay you go the gainz")
		#add logic to boost all Inu speed by 10% for 1 min
		collisions = 0
