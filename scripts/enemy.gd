extends CharacterBody2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player_group")
@onready var animated_sprite_2d = $AnimatedSprite2D

@export var base_movement_speed: float = 30.0
@export var movement_speed_variation: float = 10.0
@export var hp: int = 10

var movement_speed: float

func _ready() -> void:
	# Assign a random movement speed within the variation range
	movement_speed = base_movement_speed + randf_range(-movement_speed_variation, movement_speed_variation)

func _physics_process(_delta) -> void:
	move_to_player_position()

func move_to_player_position() -> void:
	
	var direction: Vector2 = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed	
	var has_collision: bool = move_and_slide()
	update_animation(direction, has_collision)	

func update_animation(direction: Vector2, _has_collision: bool) -> void:
	# TODO: bug => enemies can collide with each other:
	# check if the collision area is in the group of "player"
	#if has_collision:
		#animated_sprite_2d.animation = "idle";
	#else:
		#animated_sprite_2d.animation = "walk";
	
	if player.velocity == Vector2.ZERO: # no need to update animation direction if player is not moving
		return;
	elif direction.x < 0:
		animated_sprite_2d.flip_h = true
	elif direction.x > 0:
		animated_sprite_2d.flip_h = false

func _on_hurt_box_hurt(damage: int):
	hp -= damage
	print("Enemy HP:", hp)
	if hp <= 0:
		queue_free()
