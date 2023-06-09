extends Node2D

var gold_cup = load("res://img/cups/gold.png")
var silver_cup = load("res://img/cups/silver.png")
var bronze_cup = load("res://img/cups/bronze.png")

var happy_smiley = load("res://img/smileys/happy.png")
var neutral_smiley = load("res://img/smileys/neutral.png")
var sad_smiley = load("res://img/smileys/sad.png")

var positive_result_message = load("res://img/positive_result.png")
var negative_result_message = load("res://img/negative_result.png")

var bronze_count = 0
var level_completed = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if !BackgroundMusicPlayer.stream_paused and BackgroundMusicPlayer.playing:
		$Music_off.visible = false
		$Music_on.visible = true
	else: 
		$Music_off.visible = true
		$Music_on.visible = false
	
	if Global.play_sounds:
		$Sound_off.visible = false
		$Sound_on.visible = true
	else: 
		$Sound_off.visible = true
		$Sound_on.visible = false
	
	if $Sound_on.visible == true:
		$Finished_sound.play()

	show_classroom_results("math", $Cups/Math_cups, $Smileys/Math_smiley)
	show_classroom_results("nature", $Cups/Nature_cups, $Smileys/Nature_smiley)
	show_classroom_results("language", $Cups/Language_cups, $Smileys/Language_smiley)
	show_final_result()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
#    pass


func _on_to_main_menu_pressed():
	Transition.change_scene("res://main.tscn")

func show_classroom_results(classroom, cups, smiley):
	var classroom_bronze_count = 0
	var classroom_points = 0  
 
	for i in Questions.questions_from_class:
		match Global.results_by_classroom[classroom][i]:
			1:
				cups.get_child(i).set("texture", bronze_cup)
				classroom_bronze_count = classroom_bronze_count + 1
				bronze_count = bronze_count + 1
				classroom_points = classroom_points + 1
			2:
				cups.get_child(i).set("texture", silver_cup)
				classroom_points = classroom_points + 2
			3:
				cups.get_child(i).set("texture", gold_cup)
				classroom_points = classroom_points + 3

	if classroom_bronze_count >= 3 or classroom_points <= 6:
		smiley.set("texture", sad_smiley)
		level_completed = false
	else:
		if classroom_points <= 8:
			smiley.set("texture", neutral_smiley)
		else:
			smiley.set("texture", happy_smiley)

func show_final_result():
	if level_completed and bronze_count < 6:
		$Result_message/Smiley.set("texture", happy_smiley)
		$Result_message/Message.set("texture", positive_result_message)
		$ToNextLevel.visible = true
	else:
		$Result_message/Smiley.set("texture", sad_smiley)
		$Result_message/Message.set("texture", negative_result_message)
		level_completed = false

	#Global.game_results.level_results[Global.level].results.append_array(Global.level_results)
	#Global.game_results.level_results[Global.level].results_by_classroom.math.append_array(Global.results_by_classroom.math)
	#Global.game_results.level_results[Global.level].results_by_classroom.nature.append_array(Global.results_by_classroom.nature)
	#Global.game_results.level_results[Global.level].results_by_classroom.language.append_array(Global.results_by_classroom.language)
		
	if level_completed:
		Global.game_results.levels_completed = Global.game_results.levels_completed + 1


func _on_to_next_level_pressed():
	if Global.level < 1:
		Global.level = Global.level + 1
		Questions.prepare()
		Transition.change_scene("res://level1.tscn")
	else:
		Transition.change_scene("res://main.tscn")

func _on_repeat_level_pressed():
	Questions.prepare()
	Transition.change_scene("res://level1.tscn")

func _on_music_on_pressed():
	$Music_on.visible = false
	$Music_off.visible = true
	BackgroundMusicPlayer.stream_paused = true

func _on_music_off_pressed():
	$Music_off.visible = false
	$Music_on.visible = true
	BackgroundMusicPlayer.stream_paused = false

func _on_sound_on_pressed():
	$Sound_on.visible = false
	$Sound_off.visible = true
	Global.play_sounds = false

func _on_sound_off_pressed():
	$Sound_off.visible = false
	$Sound_on.visible = true
	Global.play_sounds = true
