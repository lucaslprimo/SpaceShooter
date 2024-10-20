extends Node2D

@onready var player = $Player
@onready var playerSpawnPoint = $PlayerSpawnPoint
@onready var bulletContainer = $BulletContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.global_position = playerSpawnPoint.global_position
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
	bulletContainer.add_child(bullet)
	
