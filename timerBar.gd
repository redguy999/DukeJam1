extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():#We want to wait for the 
	#startTimer()#For testing, something else should start this
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
var levelFinished = false#This will be set by other scripts.
@onready var countdown = get_node("Timer")
func _process(delta):
	scale.x = countdown.get_time_left()*10
	#Was hoping to have it get smaller to the left or right, but that seems kinda complex.
	
func startTimer():
	get_node("Timer").start()

signal timeOver
func _on_timer_timeout():
	if(levelFinished):#Sanity check in case the timer is not removed before it goes off.
		#We actually will just, not do anything, since this is the case where you won.
		pass
	else:
		timeOver.emit()
		pass
