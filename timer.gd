extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

signal timeOver
#Yes I could skip the middle man but the code stopped working when I tried to do that
func _on_timer_bar_time_over():
	timeOver.emit()
	pass # Replace with function body.
