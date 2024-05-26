extends Node2D

@export var spawn_info: Array[SpawnInfo] = []

@onready var player: Node = get_tree().get_first_node_in_group("player_group");

var timer: int = 0;

func _on_timer_timeout():
	timer += 1
	print(timer)
	var spawns = spawn_info #TODO: check if we need this variable
	for spawn in spawns: 
		if spawn.time_start <= timer && spawn.time_end >= timer:
			print("enemy spawner hit")
			if spawn.spawn_delay_counter < spawn.enemy_spawn_delay:
				print("delay counter found")
				spawn.spawn_delay_counter += 1
			else:
				spawn.spawn_delay_counter = 0
				var enemy_counter = 0
				while enemy_counter < spawn.enemy_count:
					print("spawn a new enemy")
					var enemy: PackedScene = load(spawn.enemy.resource_path)
					var enemy_spawn = enemy.instantiate()
					enemy_spawn.global_position = get_random_position()
					add_child(enemy_spawn)
					enemy_counter += 1
					
func get_random_position() -> Vector2:
	var viewport_rectangle  = get_viewport_rect().size * randf_range(1.1, 1.25);
	
	var top_left = Vector2(player.global_position.x - viewport_rectangle.x / 2, player.global_position.y - viewport_rectangle.y / 2)
	var top_right = Vector2(player.global_position.x + viewport_rectangle.x / 2, player.global_position.y - viewport_rectangle.y / 2)
	var bottom_left = Vector2(player.global_position.x - viewport_rectangle.x / 2, player.global_position.y + viewport_rectangle.y / 2)
	var bottom_right = Vector2(player.global_position.x + viewport_rectangle.x / 2, player.global_position.y + viewport_rectangle.y / 2)
	
	var positions = ["left", "right", "up", "down"].pick_random()
	var enemy_position = Vector2.ZERO;
	
	match positions:
		"up":
			enemy_position = get_random_position_coordinates(top_left, top_right)
		"down":
			enemy_position =  get_random_position_coordinates(bottom_left, bottom_right)
		"left":
			enemy_position =  get_random_position_coordinates(top_left, bottom_left)
		"right":
			enemy_position =  get_random_position_coordinates(top_right, bottom_right)
	
	return enemy_position
		
func get_random_position_coordinates(pos1: Vector2, pos2: Vector2) -> Vector2:
	var positionX = randf_range(pos1.x, pos2.x)
	var positionY = randf_range(pos1.y, pos2.y)
	
	return Vector2(positionX,positionY)
	
	
