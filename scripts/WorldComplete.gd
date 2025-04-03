# World Complete .gd

extends Area2D

export(String, FILE, "*.tscn") var next_world
export(String, FILE, "*.tscn") var world
var total_time = 500000
var current_s 
onready var start_time = OS.get_ticks_msec()



	
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
	
	for body in bodies:
		if body.name == "Player":
			
			current_s = get_tree().get_current_scene().name
			get_node("/root/SavingSystem").load_score("Score", current_s)
			set_Nextlvl()
			get_node("NextLvl/Control").show()
			get_tree().paused = true
			
			
			

func set_Nextlvl():
	if Global.hiest_score == null:
		Global.hiest_score = 0
	
	Global.current_scene = world
	Global.next_world = next_world
	
	
	if Global.total_score > Global.hiest_score:
		Global.hiest_score = Global.total_score
	
	get_node("SaveSystem").hiest_score = Global.hiest_score
	get_node("SaveSystem").save_score("Score", current_s)
	$NextLvl/Control/CenterContainer/VBoxContainer/Actual_score.text = "Aktuální skóre: " + String(Global.total_score)
	$NextLvl/Control/CenterContainer/VBoxContainer/hiest_score.text = "Nejvyšší skóre: " + String(Global.hiest_score)
	

func _on_WorldComplete_body_entered(body):
	if body.name == "Player":
		total_time = (OS.get_ticks_msec() - start_time) / 1000
		if total_time <= 150:
			Global.total_score +=250
		elif total_time <= 200 && total_time > 150:
			Global.total_score +=200
		elif total_time <= 250 && total_time > 200:
			Global.total_score +=150
		elif total_time <= 300 && total_time > 250:
			Global.total_score +=100
		elif total_time <= 400 && total_time > 300:
			Global.total_score +=100
		elif total_time <= 500 && total_time > 400:
			Global.total_score +=75
