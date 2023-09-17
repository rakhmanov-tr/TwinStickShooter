extends CharacterBody2D

class_name enemy

var health: float = 100.0
var speed: float = 200.0
var target: player


func _physics_process(_delta: float) -> void:
	if target == null: target = get_tree().get_nodes_in_group("player")[0]
	if target != null:
		velocity = position.direction_to(target.position) * speed
		move_and_slide()
		look_at(target.global_position)


func apply_damage(damage: float) -> void:
	health = clamp(health - damage, 0.0, 100.0)
#	print(health)
	if health == 0:
		GameManager.handle_enemy_death()
		queue_free()
