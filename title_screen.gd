extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func toGame():
	get_tree().change_scene_to_file("res://level_handler.tscn")

func _on_start_button_button_down():
	call_deferred("toGame")
	pass # Replace with function body.
