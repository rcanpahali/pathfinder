extends Area2D

@export_enum("Cooldown", "HitOnce", "Disabled") var BoxType = 0

@onready var collision_shape_2d = $CollisionShape2D
@onready var timer = $Timer

# create custom signal to trigger when the area is "attack_group"
signal hurt(damage: int);

func _on_area_entered(area: Area2D):
	if area.is_in_group("attack_group"):
		var enemy: Area2D = area;
		if enemy.get("damage") != null:
			match BoxType: 
				0: # Cooldown
					collision_shape_2d.set_deferred("disabled", true);
					timer.start();
				1: # HitOnce
					pass
				2: # Disabled
					if enemy.has_method("temporary_disable"):
						enemy.temporary_disable()
			var damage = enemy.damage
			emit_signal("hurt", damage)

func _on_timer_timeout():
	collision_shape_2d.set_deferred("disabled", false)
