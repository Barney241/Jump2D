extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_next_lvl_pressed():
	not get_tree().paused 
	Global.total_score = 0
	get_tree().change_scene(Global.next_world)
	


func _on_restart_lvl_pressed():
	Global.total_score = 0
	get_tree().reload_current_scene()
