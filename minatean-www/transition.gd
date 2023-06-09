extends CanvasLayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")

func smooth_quit():
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	get_tree().quit()

func smooth_start():
	$AnimationPlayer.play_backwards("dissolve")
	await $AnimationPlayer.animation_finished
