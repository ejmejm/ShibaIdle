class_name BaseBuilding
extends Area2D


#for when playerstats updated to include any building stats
const PLAYER_STATS_PATH: String = "/root/Root/GameManager/PlayerStats"

var player_stats: PlayerStats


func link_dependencies():
	pass


func _ready():
	player_stats = get_node_or_null(PLAYER_STATS_PATH)
	if player_stats == null:
		push_error("PlayerStats could not be found!")
	self.body_entered.connect(_on_body_entered)

	link_dependencies()


func _on_body_entered(body: Node2D):
	on_body_entered(body)


func on_body_entered(body: Node2D):
	pass


func choose_open_spot() -> Vector2:
	return Vector2.ZERO
