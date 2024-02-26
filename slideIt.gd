extends Node2D


# Called when the node enters the scene tree for the first time.
signal gameState(Success)#True if you won, otherwise false.
func _ready():
	get_node("Timer").timeOver.connect(timesUp)
	#Set up the game here
	pass # Replace with function body.
func timesUp():
	#If the player is suppose to win by timeout, have it emit true.
	gameState.emit(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_h_slider_value_changed(value):
	if(value>=100):
		gameState.emit(true)
