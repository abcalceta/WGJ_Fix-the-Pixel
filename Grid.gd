extends Node2D


var pixel = preload("res://Pixel.tscn")

var grid = []
var gridTemp = []
var gridHeight = 12
var gridWidth = 20
var pixelGrid = []

var xOffset = 10
var yOffset = 0

var speed = 0.0005
var speedFast = 0.01

func _ready():
	for x in range(gridHeight):
		grid.append([])
		gridTemp.append([])
		pixelGrid.append([])
		for y in range(gridWidth):
			grid[x].append(0)
			gridTemp[x].append(0)
			var newPixel = pixel.instance()
			add_child(newPixel)
			pixelGrid[x].append(newPixel)
			newPixel.position.x = (y*50)+ xOffset
			newPixel.position.y = (x*50)+ yOffset
			

	#floodFill(1,1,0,1)
	for x in range(gridHeight):
		#grid[x][4] = 1
		#gridTemp[x][4] = 1
		pass
	


func _process(delta):
	#print($FillTimer.time_left)
	$Node2D/Label.text = str(globals.swaps)
	for x in range(gridHeight):
		for y in range(gridWidth):
			if pixelGrid[x][y].isToggled == true:
				globals.noClicks = true
				globals.fillSize = 0
				fillBoard(x,y, grid[x][y], pixelGrid[x][y].color, grid)
				pixelGrid[x][y].isToggled = false
			pixelGrid[x][y].color = grid[x][y]
	
	pass
	
	
func fillBoard(x, y, targetColor, replacementColor, grid):
	floodFill(x, y, targetColor, replacementColor, grid)
	
func floodFill(x, y, targetColor, replacementColor, grid):
	if x>=gridHeight or x<0 or y>=gridWidth or y<0:
		globals.noClicks = false
		return
	elif targetColor == replacementColor:
		globals.noClicks = false
		return
	elif grid[x][y] != targetColor:
		globals.noClicks = false
		return
	else:
		grid[x][y] = replacementColor
		globals.swaps += 1
		pixelGrid[x][y].get_node("Sound").play()
		
	var Q = []
	Q.append([x,y])
	var four = 0
	while Q.size()>0:
		four += 1
		var n = Q[0]
		#print(Q[0])
		Q.erase(n)
		if not n[0]+1>=gridHeight:
			if grid[n[0]+1] [n[1]] == targetColor:
				grid[n[0]+1] [n[1]] = replacementColor
				globals.swaps += 1
				Q.append([n[0]+1,n[1]])
		if not n[0]-1<0 :
			if grid[n[0]-1] [n[1]] == targetColor:
				grid[n[0]-1][n[1]] = replacementColor
				globals.swaps += 1
				Q.append([n[0]-1,n[1]])
		if not  n[1]+1>=gridWidth :
			if grid[n[0]] [n[1]+1] == targetColor:
				grid[n[0]][n[1]+1] = replacementColor
				globals.swaps += 1
				Q.append([n[0],n[1]+1])
		if not n[1]-1<0:
			if grid[n[0]] [n[1]-1] == targetColor:
				grid[n[0]] [n[1]-1] = replacementColor
				globals.swaps += 1
				Q.append([n[0],n[1]-1])
				
		if four == 4:
			four = 0
			yield(get_tree().create_timer(speed), "timeout")
			pixelGrid[n[0]][n[1]].get_node("Sound").play()
		globals.fillSize+=1
	globals.noClicks = false
	return


func printGrid():
	for x in range(gridHeight):
		print(grid[x])



func _on_Timer_timeout():

	$Timer.start()
			
