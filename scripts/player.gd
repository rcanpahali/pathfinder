extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var SPEED: float = 200.0

var hp: int = 80

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	
	handle_movement()

func handle_movement() -> void:
		var input_direction: Vector2 = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up"))
		
		velocity = input_direction.normalized() * SPEED
		move_and_slide()		
		update_animation(input_direction)

func update_animation(input_direction: Vector2) -> void:
	#switch between states: running <--> idle
	if velocity == Vector2.ZERO:
		animated_sprite_2d.animation = "idle";
	else:
		animated_sprite_2d.animation = "walk";
	
	# look left-right
	if(input_direction.x < 0):
		animated_sprite_2d.flip_h = true;
	elif(input_direction.x > 0):
		animated_sprite_2d.flip_h = false;

func _on_hurt_box_hurt(damage: int):
	hp -= damage
	#print("Player HP:", hp)
