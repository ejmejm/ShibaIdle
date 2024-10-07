class_name InuStats
extends Node


@export var power: float = 1.0
@export var treat_power: int = 1
@export var speed: float = 1.0:
	get:
		return speed + speed_bonus * speed_bonus_effect

var speed_bonus: int = 0:
	set(val):
		speed_bonus = max(val, 0)

var speed_bonus_effect: float = 0.4
