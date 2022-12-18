extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 900
var can_hit = true

func _ready():
	velocity.x = [-1, 1][randi() % 2]
	velocity.y = [-0.8,0.8][randi() % 2 ]
	
func _physics_process(delta):
	var collision_object = move_and_collide(velocity * speed * delta)
	if collision_object:
		if collision_object.collider.is_in_group('PaddleGroup') and can_hit == true:
			print("Paddle. can_hit = TRUE")
			can_hit = false
			$PaddleCollisionTimer.start()
			velocity = velocity.bounce(collision_object.normal)
			$BounceNoise.play()
		elif collision_object.collider.is_in_group('PaddleGroup') and can_hit == false:
			pass
		else:
			velocity = velocity.bounce(collision_object.normal)
			$BounceNoise.play()

func _on_PaddleCollisionTimer_timeout():
	can_hit = true
