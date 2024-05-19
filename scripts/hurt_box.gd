extends Area2D

@export_enum("Cooldown", "HitOnce", "Disabled") var BoxType = 0

@onready var collision_shape_2d = $CollisionShape2D
@onready var timer = $Timer

signal hurt(damage)

# todos
# check how this _on_area_entered works
# re-work collision shapes

func _on_area_entered(area):
	if area.is_in_group("attack_group"):
		if area.get("damage") != null:
			match BoxType: 
				0: # Cooldown
					collision_shape_2d.set_deferred("disabled", true) # check this set_deferred or call_deferred
					timer.start()
				1: # HitOnce
					pass
				2: # Disabled
					if area.has_method("temporary_disable"):
						area.temporary_disable()
			var damage = area.damage
			emit_signal("hurt", damage)

func _on_timer_timeout():
	collision_shape_2d.set_deferred("disabled", false)


