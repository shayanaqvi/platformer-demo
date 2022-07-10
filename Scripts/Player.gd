extends KinematicBody2D

onready var animationPlayer = $AnimationPlayer
onready var tween = $Tween
onready var camera = $Camera2D

export (int) var speed = 100
export (int) var jump_speed = -400
export (int) var gravity = 2000

var velocity = Vector2.ZERO
var jump_count: = 0

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("d"):
		velocity.x += speed
		animationPlayer.play("Walk")
	if Input.is_action_pressed("a"):
		velocity.x -= speed
		animationPlayer.play("Walk")
	if velocity == Vector2(0, 0):
		animationPlayer.play("Idle")

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("w"):
		# if is_on_floor():
		if jump_count <= 0:
			jump_count += 1
			velocity.y = jump_speed
			
			if velocity.x == 1:
				velocity.x += speed * 1.5
			elif velocity.x == -1:
				velocity.x -= speed * 1.5
			
	if is_on_floor() and jump_count >= 0:
		jump_count = 0
