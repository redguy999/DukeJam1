extends Node2D


# Called when the node enters the scene tree for the first time.
#Each level must be the same as its scene name do not include the file tag
var Levels=["3buttons","3buttonsWrongColor","doNothing"]
var level=""
var levelInstructions=[
	"Click on the button that matches the text",
	#both 3 button levels should have the same instructions.
	"Click on the button that matches the text",
	"You may: Move the mouse around, click the grey background, click the timer bar, ignore the game, do nothing, drink, eat, sleep, speak, talk, will anyone even read all of this, rest, play a different game, run, hide, jump, crouch, sleep- wait I already said that, uh, I'm out of ideas
	You must: wait for the timer to run out
	You must NOT: click the button"
]
var instructions=""
var random =  RandomNumberGenerator.new()
var score = 0
func _ready():
	beginLevel()
	pass # Replace with function body.
var inst#need to hold this as global

func beginLevel():#I'll fix these names, maybe.
	get_node("levelComplete").visible=false
	get_node("gameOver").visible=false
	#TODO: randomly select a level.
	var hold = selectLevel()
	level=Levels[hold]
	instructions=levelInstructions[hold]
	if(level=="doNothing"):#The text is a bit of a meme, but you only actually need to read the last 2 lines.
		get_node("Instructions/Control/Label").size.x=1200
		get_node("Instructions/Control/Label").position.x+=(700-1200)/2
	loadLevel()
	showInstructions()
	connectLevel()
	await get_tree().create_timer(3.0).timeout#TL;DR: wait three seconds
	#That should be more than enough time to read the instructions.
	get_node("Instructions").visible=false
	getLevelTimer().get_child(0).start()#starts the timer.
	
func selectLevel():
	#return 2 #Uncomment and set to a specific number to test a level
	if(!score):#First level should be normal 3Buttons.
		return 0
	return random.randi_range(0, Levels.size()-1)
	
func connectLevel():
	inst.gameState.connect(endScreen)
	
func endScreen(boole):
	finishLevel()
	if(boole):
		if(level=="doNothing"):#Make sure to undo it here.
			get_node("Instructions/Control/Label").size.x=700
			get_node("Instructions/Control/Label").position.x+=(1200-700)/2
		get_node("levelComplete").visible=true
		score+=1
		await get_tree().create_timer(3.0).timeout#TL;DR: wait three seconds
		beginLevel()
	else:
		get_node("gameOver").visible=true
		var scoreDis = get_node("gameOver/Label")
		scoreDis.text="Score = "+str(score)
		await get_tree().create_timer(.1).timeout
		print("score moved")
		scoreDis.position.x+=(-scoreDis.size.x/2)
func loadLevel():
	var newScene = load("res://"+level+".tscn")
	inst= newScene.instantiate()
	add_child(inst)
	
func showInstructions():#Assume that the level has already been added to the tree
	get_node("Instructions").visible=true#This gets hidden at times.
	get_node("Instructions/Control/Label").text=instructions#Replace with instructions for level.

func getLevelTimer():
	for child in inst.get_children(true):
		if(child.name=="Timer"):
			return child.get_child(0)
			
func finishLevel():#more like remove level
	getLevelTimer().levelFinished=true
	inst.queue_free()#Remove the level
	
func _process(delta):
	pass
