class_name Enemy
extends CharacterBody2D

@export var speed: float = 75.0
@export var stop_distance: float = 10.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var player: Node2D

func _physics_process(_delta: float) -> void:
	# Keep searching for the player if not found yet
	if not player:
		var players: Array[Node] = get_tree().get_nodes_in_group("player")
		if players.size() > 0:
			player = players[0]
		else:
			return
			
	# Calculate distance and move toward the player
	var distance_to_player: float = global_position.distance_to(player.global_position)
	
	if distance_to_player > stop_distance:
		var direction: Vector2 = global_position.direction_to(player.global_position)
		velocity = direction * speed
		animated_sprite.play("walk")
	else:
		velocity = Vector2.ZERO
		animated_sprite.play("default")
		
	move_and_slide()
	_update_facing()

func _update_facing() -> void:
	if not player:
		return
		
	# Horizontal difference between the player and the enemy
	var dir_x: float = player.global_position.x - global_position.x
	
	# Sprite is drawn facing left by default, so flip_h = true faces right
	if abs(dir_x) > 1.0:
		animated_sprite.flip_h = dir_x > 0
