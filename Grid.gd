extends Node2D


var pixel = preload("res://Pixel.tscn")

var grid = []
var gridHeight = 12
var gridWidth = 20
var pixelGrid = []

var xOffset = 10
var yOffset = 0

var speed = 0.1

func _ready():
	for x in range(gridHeight):
		grid.append([])
		pixelGrid.append([])
		for y in range(gridWidth):
			grid[x].append(0)
			var newPixel = pixel.instance()
			add_child(newPixel)
			pixelGrid[x].append(newPixel)
			newPixel.position.x = (y*50)+ xOffset
			newPixel.position.y = (x*50)+ yOffset
			

	#floodFill(1,1,0,1)
	for x in range(gridHeight):
		grid[x][4] = 1
	


func _process(delta):
	pass

func fillBoard(x, y, targetColor, replacementColor):
	floodFill(x, y, targetColor, replacementColor)




func floodFill(x, y, targetColor, replacementColor):
	globals.fillSize += 1
	print(globals.fillSize)
	#Flood-fill (node, target-color, replacement-color):
	 #1. If target-color is equal to replacement-color, return.
	 #2. ElseIf the color of node is not equal to target-color, return.
	 #3. Else Set the color of node to replacement-color.
	 #4. Perform Flood-fill (one step to the south of node, target-color, replacement-color).
	    #Perform Flood-fill (one step to the north of node, target-color, replacement-color).
	    #Perform Flood-fill (one step to the west of node, target-color, replacement-color).
	    #Perform Flood-fill (one step to the east of node, target-color, replacement-color).
	 #5. Return.
	if x>=gridHeight or x<0 or y>=gridWidth or y<0:
		return
	elif targetColor == replacementColor:
		return
	elif grid[x][y] != targetColor:
		return
	else:
		grid[x][y] = replacementColor
	
	
	var t = Timer.new()
	t.set_wait_time(speed)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	
	floodFill(x+1, y, targetColor, replacementColor)
	var t1 = Timer.new()
	t1.set_wait_time(speed)
	t1.set_one_shot(true)
	self.add_child(t1)
	t1.start()
	yield(t1, "timeout")
	
	
	floodFill(x-1, y, targetColor, replacementColor)
	var t2 = Timer.new()
	t2.set_wait_time(speed)
	t2.set_one_shot(true)
	self.add_child(t2)
	t2.start()
	yield(t2, "timeout")
	
	
	floodFill(x, y+1, targetColor, replacementColor)
	var t3 = Timer.new()
	t3.set_wait_time(speed)
	t3.set_one_shot(true)
	self.add_child(t3)
	t3.start()
	yield(t3, "timeout")
	
	
	floodFill(x, y-1, targetColor, replacementColor)
	var t4 = Timer.new()
	t4.set_wait_time(speed)
	t4.set_one_shot(true)
	self.add_child(t4)
	t4.start()
	yield(t4, "timeout")
	return

func printGrid():
	for x in range(gridHeight):
		print(grid[x])



func _on_Timer_timeout():
	for x in range(gridHeight):
		for y in range(gridWidth):
			if pixelGrid[x][y].isToggled == true:
				globals.noClicks = true
				globals.fillSize = 0
				fillBoard(x,y, grid[x][y], pixelGrid[x][y].color)
				$Timer.stop()
				if $ClickTimer.time_left==0:
					$ClickTimer.wait_time = globals.fillSize*0.1
					$ClickTimer.start()
				pixelGrid[x][y].isToggled = false
			pixelGrid[x][y].color = grid[x][y]
	$Timer.start()

func _on_ClickTimer_timeout():
	globals.noClicks = false
