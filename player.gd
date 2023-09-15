extends CharacterBody2D

class_name player

@export var speed_multiplier: int = 1
@export var projectile: PackedScene
@onready var spawn_point: Marker2D = $Marker2D

const MOVE_SPEED: float = 500.0


func _physics_process(delta: float) -> void:
	move()
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"): shoot()


func move() -> void:
	var movement: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_left"): movement.x -= 1.0
	if Input.is_action_pressed("move_right"): movement.x += 1.0
	if Input.is_action_pressed("move_up"): movement.y -= 1.0
	if Input.is_action_pressed("move_down"): movement.y += 1.0
	velocity = movement * (MOVE_SPEED * speed_multiplier)
	move_and_slide()

func shoot() -> void:
	var inst: projectile = projectile.instantiate()
	owner.add_child(inst)
	inst.transform = spawn_point.global_transform
	print("BANG!")
