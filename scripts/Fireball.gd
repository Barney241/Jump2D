extends Area2D

const SPEED = 210


var direction = 1
var velocity = Vector2()

func _ready():
	pass # Replace with function body.

func set_fireball_direction(dir):
	direction =  dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
		
func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("shoot")






func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		body.dead()
	queue_free()
