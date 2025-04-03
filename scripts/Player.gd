extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED = 200
const ACCELERATION = 60
const JUMP_HEIGHT = -550
const FIREBALL = preload("res://scenes/Fireball.tscn")



var total_score = Global.total_score
var motion = Vector2()
var is_dead = false
var is_jumping

func _ready():
	get_tree().paused = false
	Global.current_scene = get_tree().get_current_scene().filename
	get_node("SaveSystem").DisplayValue = Global.current_scene
	get_node("SaveSystem").save_game("Values", "ValueOne")

# warning-ignore:unused_argument
func _physics_process(delta):
	
	if is_dead == false:
		add_to_group("player")
		motion.y += GRAVITY
		var friction = false
	      
		if Input.is_action_pressed("ui_right"):
			
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$Sprite.play("Run")
			
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
			
		elif Input.is_action_pressed("ui_left"):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$Sprite.play("Run")
			
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
				
		else: 
			$Sprite.play("Idle")
			friction = true
			motion.x = lerp(motion.x, 0,0.2)
			
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
				
			if friction == true:
				motion.x = lerp(motion.x, 0,0.2)
			
				
		else:
			if motion.y < 0:
				$Sprite.play("Jump")
				
			else:
				$Sprite.play("Fall")
				
			if friction == true:
				motion.x = lerp(motion.x, 0,0.05)
				
		if is_jumping && motion.y >= 0:
			is_jumping = false
		if motion.y == JUMP_HEIGHT:
			is_jumping = true
			
		if Input.is_action_just_pressed("Fire"):
			var fireball = FIREBALL.instance()
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
			
		var snap = Vector2.DOWN * 32 if !is_jumping else Vector2.ZERO
		motion = move_and_slide_with_snap(motion, snap, UP)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy_0" in get_slide_collision(i).collider.name:
					dead()
				
		
func dead():
	is_dead = true
	motion =  Vector2(0, 0)
	$CollisionShape2D.disabled = true
	$Sprite.play("Dead")
	Global.total_score = 0
	$Timer.start()
	
func done():
	motion =  Vector2(0, 0)
	$CollisionShape2D.set_deferred("disabled", true)
	
func save():
	var name = get_parent().name
	var world = "res://worlds/" + name + ".tscn"
	return world
	


func _on_Timer_timeout():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func end_of_game(score):
	Global.total_score += 5
	
	
	
func show_score_current_match():
	
	var dd = String(Global.total_score)
	$RichTextLabel.text = "Score: " + dd
	


func _on_UpdateScore_timeout():
	
	show_score_current_match()
	
