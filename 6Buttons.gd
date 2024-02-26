extends Node2D

#All levels need to have a script on the highest node
#This node will recieve the signal that the elements of the level emits
#This signal will then be sent to the level handler from this node.
# Called when the node enters the scene tree for the first time.
var correctButton
func _ready():
	get_node("Timer").timeOver.connect(timesUp)
	makeAnswer()
	placeButtons()

signal gameState(Success)#True if you won, otherwise false.
func timesUp():
	gameState.emit(false)

func gameWon():
	gameState.emit(true)

var random =  RandomNumberGenerator.new()

func makeAnswer():
	pass
	
var buttonColors = ["red","green","blue","Magenta","yellow","Cyan"]

func placeButtons():
	random.randomize()
	var picker = random.randi_range(0, 5)
	var nodes = ["LeftUpper","MiddleUpper","RightUpper","LeftLower","MiddleLower","RightLower"]
	#get_node("Left/blue")
	var counter = 5
	for node in nodes:
		picker = random.randi_range(0, counter)
		get_node(node+"/"+buttonColors[picker]).visible=true
		buttonColors.pop_at(picker)
		counter-=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_red_button_down():
	if(correctButton=="red"):
		gameWon()
	else:
		timesUp()
	pass # Replace with function body.


func _on_blue_button_down():
	if(correctButton=="blue"):
		gameWon()
	else:
		timesUp()
	pass # Replace with function body.


func _on_green_button_down():
	if(correctButton=="green"):
		gameWon()
	else:
		timesUp()
	pass # Replace with function body.


func _on_yellow_button_down():
	if(correctButton=="yellow"):
		gameWon()
	else:
		timesUp()
	pass # Replace with function body.


func _on_cyan_button_down():
	if(correctButton=="Cyan"):
		gameWon()
	else:
		timesUp()
	pass # Replace with function body.


func _on_magenta_button_down():
	if(correctButton=="Magenta"):
		gameWon()
	else:
		timesUp()
	pass # Replace with function body.
