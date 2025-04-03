extends Node

onready var begin = OS.get_ticks_msec()
var total_score 


func end_of_game(score):
	total_score = score
	
	

func nvm():
	show_score_current_match()
func end_game():
	var elapsed_time = OS.get_ticks_msec() - begin
	return elapsed_time



func update_total_score(score):
	total_score += score
	



func show_score_current_match():
	var dd = String(total_score)
	$RichTextLabel.text = dd
	

func show_total_score(score):
    	$ScoreLabel.text = "Final score: " + str(total_score)
    	$ScoreLabel.show()