extends Area2D

const SPEED = 160


var direction = 1
var velocity = Vector2()

func _ready():
	pass # Replace with function body.

func set_fireball_direction(dir):
	direction =  dir
	if dir == -1:
		$AnimatedSprite.flip_h = false
		
func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("shoot")



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.dead()
	queue_free()
