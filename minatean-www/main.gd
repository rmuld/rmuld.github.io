extends Node2D

var exitNode = preload("res://exit_confirm.tscn")

func _init():
    Transition.smooth_start()
# Called when the node enters the scene tree for the first time.

func _ready():
    add_exit_confirm(exitNode)
    
    if !BackgroundMusicPlayer.stream_paused and BackgroundMusicPlayer.playing:
        $Music_off.visible = false
    else: 
        $Music_on.visible = true

    if Global.play_sounds:
        $Sound_off.visible = false
    else: 
        $Sound_off.visible = true

    for i in range(min(Global.game_results.levels_completed + 1, Global.NUM_OF_LEVELS)):
        $Levels.get_child(i).set("visible", true)
        $Levels.get_child(i).disabled = false
        $Levels.get_child(i).get_child(0).set("visible", true)
        

    Questions.read_questions()
    # get_node("Label").set("text", Questions.topic)
    
    

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
#    pass
    
func _on_level1_pressed():
    # get_tree().change_scene_to_file("res://level1.tscn")
    Global.level = 0
    Questions.prepare()
    Transition.change_scene("res://level1.tscn")

func _on_level_2_pressed():
    Global.level = 1
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

func add_exit_confirm(node): 
    get_node("/root/main").add_child(node.instantiate())
    get_node("/root/main/Exit_confirm/AnimationPlayer/Modal/Exit").pressed.connect(exit)
    get_node("/root/main/Exit_confirm/AnimationPlayer/Modal/Cancel").pressed.connect(cancel)
    get_node("/root/main/Exit_confirm/AnimationPlayer/Modal").hide()
    get_node("/root/main/Exit_confirm/AnimationPlayer/Dark").hide()
    #get_node("/root/main/Exit_confirm/AnimationPlayer/Modal").hide()
    #add_child.call_deferred(node_instance)
    return

func _on_exit_pressed():
    disable_buttons()
    get_node("/root/main/Exit_confirm/AnimationPlayer/Dark").show()
    get_node("/root/main/Exit_confirm/AnimationPlayer/Modal").show()
    get_node("/root/main/Exit_confirm/AnimationPlayer").play("zoom")
    #exitNode.

func exit():
    var animation = get_node("/root/main/Exit_confirm/AnimationPlayer")
    animation.play_backwards("zoom")
    await animation.animation_finished
    get_node("/root/main/Exit_confirm/").visible = false
    get_node("/root/main/Exit_confirm/AnimationPlayer/Modal").hide()
    get_node("/root/main/Exit_confirm/AnimationPlayer/Dark").hide()
    
    Transition.smooth_quit()
    
func cancel():
    var animation = get_node("/root/main/Exit_confirm/AnimationPlayer")
    animation.play_backwards("zoom")
    await animation.animation_finished
    get_node("/root/main/Exit_confirm/").visible = false
    get_node("/root/main/Exit_confirm/AnimationPlayer/Modal").hide()
    get_node("/root/main/Exit_confirm/AnimationPlayer/Dark").hide()
    enable_buttons()
#var myNode = preload("Drag and Drop type your path here")
#func add_myNode _to_my_game(): 
#	var myNode _instance =  myNode .instance() 
#	get_tree().get_root().add_child(myNode_instance)
#	#set position if needed
#	myNode_instance.global_transform = global_transform

func enable_buttons():
    for i in range(min(Global.game_results.levels_completed + 1, Global.NUM_OF_LEVELS)):
        $Levels.get_child(i).disabled = false
        $Main_menu/Main_menu.disabled = false	

func disable_buttons():
    for i in range(6):
        $Levels.get_child(i).disabled = true
        #$Levels.get_child(i).get_child(0).set("visible", true)
        $Main_menu/Main_menu.disabled = true	
