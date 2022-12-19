extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 1000
var can_hit = true

func _ready():
	velocity.x = [-1, 1][randi() % 2]
	velocity.y = [-0.8,0.8][randi() % 2 ]
	velocity = velocity.normalized()
	
func _physics_process(delta):
	var collision_object = move_and_collide(velocity * speed * delta)
	if collision_object:
		if collision_object.collider.is_in_group('PaddleGroup') and can_hit == true:
			can_hit = false
			collision_layer = 2
			collision_mask = 2
			$PaddleCollisionTimer.start()
			#velocity = velocity.bounce(collision_object.normal)
			velocity.y = collision_object.collider.global_position.direction_to(global_position).y	
			velocity.x = -velocity.x
			velocity = velocity.normalized()
			$BounceNoise.play()
		elif collision_object.collider.is_in_group('PaddleGroup') and can_hit == false:
			pass
		else:
			velocity = velocity.bounce(collision_object.normal)
			$BounceNoise.play()

func _on_PaddleCollisionTimer_timeout():
	can_hit = true
	collision_layer = 1
	collision_mask = 1
