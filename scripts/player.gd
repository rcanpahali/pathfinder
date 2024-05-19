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
		updateAnimation(input_direction)

func updateAnimation(input_direction: Vector2) -> void:
	#switch between states: running <--> idle
	if(velocity == Vector2.ZERO):
		animated_sprite_2d.animation = "idle";
	else:
		animated_sprite_2d.animation = "walk";
	
	# look left-right
	if(input_direction.x < 0):
		animated_sprite_2d.flip_h = true;
	elif(input_direction.x > 0):
		animated_sprite_2d.flip_h = false;
	else: 
		return;
	
#func update_animation_position_parameters(move_input: Vector2) -> void:
	#if move_input != Vector2.ZERO:
		#animation_tree.set("parameters/Walk/blend_position", move_input)
		#animation_tree.set("parameters/Idle/blend_position", move_input)

#func update_animation_state_machine(move_input: Vector2) -> void:
	#if move_input != Vector2.ZERO:
		#state_machine.travel("Walk") #Switch between state machine  definitions
	#else:
		#state_machine.travel("Idle")


func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
