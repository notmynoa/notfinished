class_name Player
extends CharacterBody2D

@export var speed: float = 150.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	# Input.get_vector automatically normalizes diagonal movement
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Apply velocity and move the body
	velocity = input_dir * speed
	move_and_slide()
	
	_update_animation_and_facing()

func _update_animation_and_facing() -> void:
	# Handle Animation State
	if velocity.length() > 0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("default")
		
	# Handle Sprite Flipping (Updated to > 0 since your sprite is drawn facing left)
	if velocity.x != 0:
		animated_sprite.flip_h = velocity.x > 0
