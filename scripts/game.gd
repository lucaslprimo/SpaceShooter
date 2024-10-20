extends Node2D

@export var enemies:Array[PackedScene]  = []

@onready var player = $Player
@onready var player_spawn_point = $PlayerSpawnPoint
@onready var bullet_container = $BulletContainer
@onready var enemy_container = $EnemyContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.global_position = player_spawn_point.global_position
	player.shoot_event.connect(on_player_shoot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func on_player_shoot(bullet_scene, location):
	var bullet = bullet_scene.instantiate()
	bullet.global_position = location
	bullet_container.add_child(bullet)
	
func spawn_random_enemy():
	var enemy = enemies.pick_random().instantiate()
	enemy.global_position = Vector2(1940, randi_range(0, 1080))
	enemy_container.add_child(enemy)

func _on_timer_timeout() -> void:
	spawn_random_enemy()
