#Enemy.gd

extends KinematicBody2D


const FIREBALL = preload("res://scenes/Turret_fireball.tscn")
const FLOOR = Vector2(0, -1)


export(int) var hp = 1
export(float) var cooldown = 0.5
export(Vector2) var size = Vector2(1, 1)
onready var hpc = hp
var direction = 1
var velocity = Vector2()
var is_dead = false
var score

func _ready():
	scale = size
	$shoot.wait_time = cooldown
	
	
func dead():
	hp -= 1
	if hp <= 0:
		is_dead = true
		velocity = Vector2(0,0)
		$AnimatedSprite.play("hit")
		$CollisionShape2D.set_deferred("disabled", true)
		score = (20 * hpc+ 50 - cooldown * 3)* size.x
		Global.total_score += score
		$Timer.start()
		$shoot.queue_free()
	else:
		_on_hit_timeout()
		$AnimatedSprite.play("hit")

func shoot():
	
	var fireball = FIREBALL.instance()
	
	fireball.set_fireball_direction(1)
	
	fireball.set_fireball_direction(-1)
	get_parent().add_child(fireball)
	fireball.position = $Position2D.global_position
	
	
	
        
	

func _on_Timer_timeout():
	$AnimatedSprite.play("hit")
	queue_free()



func _on_hit_timeout():
	if hp <= 0:
		$AnimatedSprite.play("hit")
	else:
		$AnimatedSprite.play("idle")
	


func _on_shoot_timeout():
	shoot()
