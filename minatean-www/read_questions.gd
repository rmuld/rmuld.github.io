extends Node

#var path = "/path/to/some.mp3"
#var snd_file=File.new()
#snd_file.open(path, File.READ)
#var stream = AudioStreamMP3.new()
#stream.data = snd_file.get_buffer(snd_file.get_len())


var topic = ""
var levels
var questions
var questions_from_class = 4
var file

func read_questions():
    if FileAccess.file_exists("questions.json"):
        file = FileAccess.open("questions.json", FileAccess.READ)
    else:
        if FileAccess.file_exists("res://questions.json"):
            file = FileAccess.open("res://questions.json", FileAccess.READ)
        else:
            return # Error! We don't have a save to load.
            
    var data = file.get_as_text()

    var json = JSON.new()
    json.parse(data)
        
    var game_data = json.data
    levels = game_data["levels"]

    return

func prepare():
    Global.init_results()
    questions = []
    Global.question = 0
    var classrooms = levels[Global.level]
    for cls in classrooms:
        Global.results_by_classroom[cls] = []  
        classrooms[cls].questions.shuffle()
        for i in questions_from_class:
            var new_question = classrooms[cls].questions[i]
            new_question["classroom"] = cls
            questions.append(new_question)
    questions.shuffle()          

func current():
    return questions[Global.question]

func size():
    return questions.size()
