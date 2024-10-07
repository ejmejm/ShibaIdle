extends Sprite2D

@export var fluctuation_speed: float = 1.0
@export var min_opacity: float = 0.0
@export var max_opacity: float = 1.0

var time: float = 0.0


func _process(delta: float) -> void:
	time += delta * fluctuation_speed
	var opacity = remap(sin(time), -1.0, 1.0, min_opacity, max_opacity)
	modulate.a = opacity


func remap(value: float, start1: float, stop1: float, start2: float, stop2: float) -> float:
	return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1))
