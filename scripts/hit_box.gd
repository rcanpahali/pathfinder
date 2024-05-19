extends Area2D

@export var damage: int = 1

@onready var collision_shape_2d = $CollisionShape2D
@onready var timer = $Timer

func temporary_disable() -> void:
	collision_shape_2d.set_deferred("disabled", true)
	timer.start()


func _on_timer_timeout():
	collision_shape_2d.set_deferred("disabled", false)
