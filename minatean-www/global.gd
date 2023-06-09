extends Node

const NUM_OF_QUESTIONS = 12
const NUM_OF_LEVELS = 2
var level = 0
var question = 0

var right_answers = 0
var wrong_answers = 0

var level_results = []
var results_by_classroom = {}

var play_sounds = true

var game_results = {"levels_completed": 0, "level_results": []}


# Called when the node enters the scene tree for the first time.
func _ready():
    #init_results()
    init_game_results()

func init_results():
    level_results = []
    level_results.resize(NUM_OF_QUESTIONS)
    results_by_classroom = {}

func init_game_results():
        game_results.level_results.resize(NUM_OF_LEVELS)
        
        for l in game_results.level_results:
                l = {"results": [],
                        "results_by_classroom": {"math": [], "nature": [], "language": []},
                }
                            
# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
#    pass
