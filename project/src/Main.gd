extends Node2D

export(PackedScene) var ball_scene

var ball
var enemy_score = 0
var player_score = 0

func _ready():
	randomize()

func spawnBall():
	var ball = ball_scene.instance()
	ball.position = $BallSpawnLocation.position	
	yield(get_tree().create_timer(1.0), "timeout")
	add_child(ball)

func _on_Start_pressed():
	spawnBall()
	$Start.hide()
	$Instructions.hide()
	enemy_score = 0
	player_score = 0
	$PlayerScoreLabel.text = "Player Score: " + str(player_score)
	$EnemyScoreLabel.text = "Enemy Score: " + str(enemy_score)
	
func _on_PlayerGoal_body_entered(body):
	if body == $Ball:
		$ScoreSound.play()
		update_enemy_score()
		$Ball.queue_free()
		remove_child($Ball)
		if enemy_score == 10:
			$Instructions.text = "You lose!"
			$Instructions.show()
			$Start.text = "Play Again"
			$Start.show()
		else:	
			yield(get_tree().create_timer(1.0), "timeout")
			spawnBall()

func _on_EnemyGoal_body_entered(body):
	if body == $Ball:
		$ScoreSound.play()
		update_player_score()
		$Ball.queue_free()
		remove_child($Ball)
		if player_score == 10:
			$Instructions.text = "You win!"
			$Instructions.show()
			$Start.text = "Play Again"
			$Start.show()
		else:
			spawnBall()

		
func update_player_score():
	player_score = player_score + 1
	$PlayerScoreLabel.text = "Player Score: " + str(player_score)
	
func update_enemy_score():
	enemy_score = enemy_score + 1
	$EnemyScoreLabel.text = "Enemy Score: " + str(enemy_score)			
