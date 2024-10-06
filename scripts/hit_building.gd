extends StaticBody2D
#put the logic here to determine impact on a building\

#for when playerstats updated to include any building stats
const PLAYER_STATS_PATH: String = "/root/Root/GameManager/PlayerStats"

var collisions : int =  0
var collision_max: int = 10
var player_stats: PlayerStats


func _ready():
	player_stats = get_node_or_null(PLAYER_STATS_PATH)
	if player_stats == null:
		push_error("PlayerStats could not be found at !")

func _on_rigid_body_2d_body_entered(body):
	collisions += 1
	if collisions >= 10:
		print("yay you go the gainz")
		#add logic to boost all Inu speed by 10% for 1 min
		collisions = 0

func _physics_process(delta):
	#needs physics to fix this in place and have it bounce stuff off. This should be a static body but oops
	pass
