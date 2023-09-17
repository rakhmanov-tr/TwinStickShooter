extends Node

@onready var enemy_scene: PackedScene = load("res://enemy.tscn")

var  wave: int = 1
var enemies_remaining: int = 2
var spawn_count: int = 0
var spawn_point: Array[Node] = []
var level: Node2D
var spawn_timer: Timer
var time_between_spawn: float = 1.0


func _ready() -> void:
	level = get_tree().get_first_node_in_group("level")
	spawn_point = get_tree().get_nodes_in_group("spawn")
	initialize_spawn_timer()
	handle_next_wave()

func initialize_spawn_timer() -> void:
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.wait_time = time_between_spawn
	spawn_timer.one_shot = false
	spawn_timer.timeout.connect(spawn_enemy)


func handle_next_wave() -> void:
	spawn_count = 0
	spawn_timer.start()


func spawn_enemy() -> void:
	var random_spawn: Node2D = \
		spawn_point[randi_range(0, spawn_point.size() - 1)]
	var inst = enemy_scene.instantiate()
	level.add_child(inst)
	inst.global_position = random_spawn.global_position
	spawn_count += 1
	if spawn_count == wave * 2:
		spawn_timer.stop()


func handle_enemy_death() -> void:
	enemies_remaining -= 1
	if enemies_remaining == 0:
		wave += 1
		enemies_remaining = wave * 2
		handle_next_wave()
