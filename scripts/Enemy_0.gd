#Enemy.gd

extends KinematicBody2D
var player = load("res://scripts/Player.gd").new()

var GRAVITY = 10
const FLOOR = Vector2(0, -1)

export(int) var speed = 40
export(int) var hp = 1
export(int) var score_plus = 0
export(Vector2) var size = Vector2(1, 1)

var direction = 1
var velocity = Vector2()
var is_dead = false
var hp_current = hp
var score = 0
onready var hpc = hp



func _ready():
	scale = size
	
	
func dead():
	
	hp -= 1
	if hp <= 0:
		is_dead = true
		GRAVITY = 0
		velocity = Vector2(0,0)
		$AnimatedSprite.play("dead")
		$CollisionShape2D.set_deferred("disabled", true)
		score = (10 * hpc + 0.5* speed + 10 * size.x+ score_plus)
		Global.total_score += score
		
	
		
	
		
		$Timer.start()
	else:
		_on_hit_timeout()
		$AnimatedSprite.play("Hit")
		

func _physics_process(delta):
	if is_dead == false:
		
		velocity.x = speed * direction
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
	
	if direction ==1:
		$AnimatedSprite.flip_h = false
		
	else:
		$AnimatedSprite.flip_h = true
		
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
	
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
	
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.dead()
	
	
		
	

func _on_Timer_timeout():
	$AnimatedSprite.play("dead")
	queue_free()


func _on_hit_timeout():
	if hp <= 0:
		$AnimatedSprite.play("dead")
	else:
		$AnimatedSprite.play("Run")
	
