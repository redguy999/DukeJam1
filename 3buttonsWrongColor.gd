extends Node2D

#All levels need to have a script on the highest node
#This node will recieve the signal that the elements of the level emits
#This signal will then be sent to the level handler from this node.
# Called when the node enters the scene tree for the first time.
var correctButton
func _ready():
	get_node("Timer").timeOver.connect(timesUp)
	placeButtons()
	makeAnswer()
	pass # Replace with function body.
signal gameState(Success)#True if you won, otherwise false.
func timesUp():
	gameState.emit(false)

func gameWon():
	gameState.emit(true)

var random =  RandomNumberGenerator.new()

func makeAnswer():
	var picker = random.randi_range(0, 2)
	correctButton=buttonCombos[0][picker]
	var word = get_node("Label")
	word.text=correctButton.to_upper()
	#Get a different color
	var falseColor = buttonCombos[0].duplicate()
	falseColor.pop_at(picker)
	picker = random.randi_range(0, 1)
	word.modulate=falseColor[picker]
	await get_tree().create_timer(.5).timeout
	#A wait is required otherwise size will not have updated yet.
	#set_defered might work but I'm not sure how i'd write that.
	word.position.x+=(-word.size.x/2)

var buttonCombos=[#Hardcoding it cause its quicker
	["red","green","blue"],
	["red","blue","green"],
	["blue","red","green"],
	["blue","green","red"],
	["green","red","blue"],
	["green","blue","red"]
]

func placeButtons():
	random.randomize()
	var picker = random.randi_range(0, 5)
	var nodes = ["Left","Middle","Right"]
	#get_node("Left/blue")
	for i in range(nodes.size()):
		get_node(nodes[i]+"/"+buttonCombos[picker][i]).visible=true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_red_button_down():
	if(correctButton=="red"):
		gameWon()
	else:
		timesUp()


func _on_blue_button_down():
	if(correctButton=="blue"):
		gameWon()
	else:
		timesUp()


func _on_green_button_down():
	if(correctButton=="green"):
		gameWon()
	else:
		timesUp()
