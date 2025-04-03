extends Node


var total_score = 0
var hiest_score = 0
var total_time = 0
var current_scene
var next_world


func _ready():
	total_score = 0
	

func end_of_game(score):
	Global.total_score += score
