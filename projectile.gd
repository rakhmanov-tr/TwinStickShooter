extends Area2D

class_name projectile

var speed: float = 25.0
var damage: float = 30.0
var spawned_from: Node
var time_to_live: float = 0.5	


func _ready() -> void:
	body_entered.connect(on_body_entered)
	handle_time_to_live()


func on_body_entered(body: Node2D) -> void:
	if body == spawned_from: return
	if body is enemy:
		var enemy_: enemy = body as enemy
		enemy_.apply_damage(damage)
#	destroy projectile
	queue_free()


func handle_time_to_live() -> void:
#	timer is from 1.0 to 0.0, then destroy projectile 
	var ttl_timer: Timer = Timer.new()
	add_child(ttl_timer)
	ttl_timer.wait_time = time_to_live
	ttl_timer.one_shot = true
	ttl_timer.timeout.connect(func(): queue_free())
	ttl_timer.start()

func _physics_process(_delta: float) -> void:
	position += transform.x * speed
