extends KinematicBody2D

var speed = 500
var ball

func _ready():
	pass

func _physics_process(delta):
	move_and_slide(Vector2(0,get_opponent_direction()) * speed)
	
func get_opponent_direction():
	if get_parent().has_node("Ball"):
		ball = get_parent().get_node("Ball")
		if abs(ball.position.y - position.y) > 25:
			if ball.position.y > position.y: return 1
			else: return -1
		else: return 0
	else: return 0	
