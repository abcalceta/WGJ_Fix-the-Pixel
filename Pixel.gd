extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var isInside = false
var isToggled = false
var color = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not isToggled: 
		$pixel.modulate = Color(0.94,0.94,0.94)
	elif isToggled:
		$pixel.modulate = Color(1,1,1)
	
	if (not globals.noClicks) and isInside and Input.is_action_just_pressed("leftMouseClick"):
		color = 1
		if not isToggled: 
			#print("clicked")
			isToggled = true
		elif isToggled:
			#print("clicked2")
			isToggled = false
	if (not globals.noClicks) and isInside and Input.is_action_just_pressed("rightMouseClick"):
		color = 2
		if not isToggled: 
			#print("clicked")
			isToggled = true
		elif isToggled:
			#print("clicked2")
			isToggled = false
			
	if color == 0:
		$pixel.texture = load("res://pixel.png")
	elif color == 1: 
		$pixel.texture = load("res://red.png")
	elif color == 2: 
		$pixel.texture = load("res://yellow.png")

func _on_StaticBody2D_mouse_entered():
	isInside = true
func _on_StaticBody2D_mouse_exited():
	isInside = false
