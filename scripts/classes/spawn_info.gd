extends Resource

class_name SpawnInfo

@export var time_start: int;
@export var time_end: int;
@export var enemy: Resource;
@export var enemy_count: int;
@export var enemy_spawn_delay: int;

var spawn_delay_counter = 0;

