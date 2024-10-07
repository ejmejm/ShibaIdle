extends Area2D


@onready var spawner: SpawnManager = $/root/Root/GameManager/Spawner


func _on_body_entered(body: Node2D) -> void:
	if body is InuController and body != %Controller:
		var inu: Inu = body.get_parent()
		var inu_container: Node = inu.get_parent()
		if randf() < 0.01:
			spawner.call_deferred("spawn_inu", "ghost_shiba", inu.position)
			inu_container.remove_child(inu)
			inu.queue_free()
