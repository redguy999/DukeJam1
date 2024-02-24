extends Node2D


# Called when the node enters the scene tree for the first time.
#Each level must be the same as its scene name do not include the file tag
var Levels=["3buttons","3buttonsWrongColor"]
var level=""
var levelInstructions=[
	"Click on the button that matches the text",
	#both 3 button levels should have the same instructions.
	"Click on the button that matches the text"
]
var instructions=""
func _ready():
	beginLevel()
	pass # Replace with function body.
var inst#need to hold this as global
func beginLevel():#I'll fix these names, maybe.
	get_node("levelComplete").visible=false
	get_node("gameOver").visible=false
	#TODO: randomly select a level.
	level=Levels[0]#Temp
	instructions=levelInstructions[0]
	loadLevel()
	showInstructions()
	connectLevel()
	print(inst.get_children())
	await get_tree().create_timer(3.0).timeout#TL;DR: wait three seconds
	#That should be more than enough time to read the instructions.
	print(inst.get_children())
	get_node("Instructions").visible=false
	print(inst.get_children())
	#Need to connect to the completion node.
	print(inst.get_children())
	getLevelTimer().get_child(0).start()#starts the timer.
func connectLevel():
	inst.gameState.connect(endScreen)
func endScreen(boole):
	finishLevel()
	if(boole):
		get_node("levelComplete").visible=true
	else:
		get_node("gameOver").visible=true
func loadLevel():
	var newScene = load("res://"+level+".tscn")
	inst= newScene.instantiate()
	add_child(inst)
	print(inst.get_children())#but works here.
func showInstructions():#Assume that the level has already been added to the tree
	get_node("Instructions").visible=true#This gets hidden at times.
	get_node("Instructions/Control/Label").text=instructions#Replace with instructions for level.
func getLevelTimer():
	for child in inst.get_children(true):#getChildren fails here
		if(child.name=="Timer"):
			return child.get_child(0)
func finishLevel():
	getLevelTimer().levelFinished=true
	inst.queue_free()#Remove the level
	get_node('levelComplete').visible=true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
