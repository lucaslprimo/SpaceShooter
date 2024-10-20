class_name Player extends CharacterBody2D

@export var acceleration = 5

@export var fire_cd = 0.3

@onready var bulletSpawnPoint = $BulletSpawnPoint

signal shoot_event

var shouldShoot = true

var bullet = preload("res://scenes/bullet.tscn")

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		if(shouldShoot):
			shoot()
			shouldShoot = false
			await get_tree().create_timer(fire_cd).timeout
			shouldShoot = true

func _physics_process(delta: float) -> void:
	var direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down"))
	velocity =  velocity + direction * acceleration;
	move_and_slide()

func die():
	queue_free()

func shoot():
	shoot_event.emit(bullet, bulletSpawnPoint.global_position)
