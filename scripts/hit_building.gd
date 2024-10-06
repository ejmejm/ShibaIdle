extends StaticBody2D
#put the logic here to determine impact on a building\

#for when playerstats updated to include any building stats
const PLAYER_STATS_PATH: String = "/root/Root/GameManager/PlayerStats"

var collisions : int =  0
var collision_max: int = 10
var player_stats: PlayerStats
var inu_stats: InuStats


func _ready():
	player_stats = get_node_or_null(PLAYER_STATS_PATH)
	if player_stats == null:
		push_error("PlayerStats could not be found at !")

func _on_rigid_body_2d_body_entered(body):
	collisions += 1
	if collisions >= 10:
		collisions = 0
		inu_stats.speed *= 1.1
		await get_tree().create_timer(60).timeout
		inu_stats.speed = 1.0
		print("the speed boost is working")
		#add logic to boost all Inu speed by 10% for 1 min
		

func choose_open_spot() -> Vector2:
	#pick an unclaimed building spot
	#currently placeheld for testing
	var placeholder = Vector2(-300,0)
	return placeholder
	

func _physics_process(delta):
	#needs physics to fix this in place and have it bounce stuff off. This should be a static body but oops
	pass
