extends Timer


@onready var inu_container: Node2D = %InuContainer


func _on_timeout():
	for node in inu_container.get_children():
		if node is not Inu:
			continue
		
		var inu: Inu = node
		print(inu.stats.speed)
		inu.stats.speed_bonus -= 1
