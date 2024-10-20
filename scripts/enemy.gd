class_name Enemy extends Area2D

@export var speed = 100
@export var hp = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x += -speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
func die():
	queue_free()
	
func hit(damage):
	hp-=damage
	blink()
	await get_tree().create_timer(0.1).timeout
	reset_color()
	if hp <= 0:
		die()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
		
# Function to make the sprite blink white
func blink():
	modulate = Color(255, 3, 3, 255)  # Set color to white

# Function to reset the sprite to its original color
func reset_color():
	modulate = Color(1, 1, 1, 1)
