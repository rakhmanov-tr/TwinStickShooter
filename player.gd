extends CharacterBody2D

class_name player

@export var speed_multiplier: int = 1
const MOVE_SPEED: float = 500.0


func _physics_process(delta: float) -> void:
	move()
	
func move():
	var movement: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_left"): movement.x -= 1.0
	if Input.is_action_pressed("move_right"): movement.x += 1.0
	if Input.is_action_pressed("move_up"): movement.y -= 1.0
	if Input.is_action_pressed("move_down"): movement.y += 1.0
	velocity = movement * (MOVE_SPEED * speed_multiplier)
	move_and_slide()
