extends Node2D


# Called when the node enters the scene tree for the first time.
#Each level must be the same as its scene name do not include the file tag
var Levels=["3 buttons","3 buttons Wrong color"]
var level=""
func _ready():
	beginLevel()
	pass # Replace with function body.
var inst#need to hold this as global
func beginLevel():#I'll fix these names, maybe.
	loadLevel()
	#Insert getting the instructions here.
	showInstructions()
	await get_tree().create_timer(5.0).timeout#TL;DR: wait five seconds
	#That should be more than enough time to read the instructions.
	get_node("Instructions").visible=false
	#Need to connect to the completion node.
	getLevelTimer().start()#starts the timer.
func loadLevel():
	var newScene = load("res://"+level+".tscn")
	inst= newScene.instantiate()
	add_child(inst)
func showInstructions():#Assume that the level has already been added to the tree
	get_node("Instructions").visible=true#This gets hidden at times.
	get_node("Instructions/Control/Label").text="Testing"#Replace with instructions for level.
func getLevelTimer():
	for child in inst.getChildren():
		if(child.name=="Timer"):
			return child
func finishLevel():
	getLevelTimer().levelFinished=true
	inst.queue_free()#Remove the level
	get_node('LevelComplete').visible=true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
