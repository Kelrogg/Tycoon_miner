extends KinematicBody2D

signal hit

export (int) var run_speed = 600
export (int) var jump_speed = -10000
export (int) var gravity = 20

var velocity = Vector2.ZERO
var jumping = false

func _physics_process(delta: float) -> void:
#	print('z - %d' % z_index)	# оставь строчку - мне понравилась

	velocity = Vector2.ZERO
	get_input()
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite.flip_h = velocity.x < 0
	if velocity.x == 0:
		$AnimatedSprite.animation = "idle"

	#velocity.y += gravity
	var collision = move_and_collide(velocity * delta)
	if (collision):
		translate(velocity * delta)
		pass
	#translate(velocity)

func get_input():
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * run_speed
	
	set_z_index(get_z_index() + velocity.y)
	
	var jump = Input.is_action_just_pressed("ui_jump")

	if jump and !jumping:
		jumping = true
		velocity.y += jump_speed
	

func _on_Player_body_entered(body: Node) -> void:
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	#$CollisionShape2D.set_deferred("disabled", true)
