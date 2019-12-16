extends Node2D


var pixel = preload("res://Pixel.tscn")

var grid = []
var gridTemp = []
var gridHeight = 12
var gridWidth = 20
var pixelGrid = []

var xOffset = 10
var yOffset = 0

var speed = 0.1
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
	pass
	
	
func fillBoardFast(x, y, targetColor, replacementColor, grid):
	floodFillFast(x, y, targetColor, replacementColor, grid)
	
func floodFillFast(x, y, targetColor, replacementColor, grid):
	if x>=gridHeight or x<0 or y>=gridWidth or y<0:
		return
	elif targetColor == replacementColor:
		return
	elif grid[x][y] != targetColor:
		return
	else:
		grid[x][y] = replacementColor
		
	var Q = []
	Q.append([x,y])
	while Q.size()>0:
		var n = Q[0]
		print(Q[0])
		Q.erase(n)
		if not n[0]+1>=gridHeight:
			if grid[n[0]+1] [n[1]] == targetColor:
				grid[n[0]+1] [n[1]] = replacementColor
				Q.append([n[0]+1,n[1]])
		if not n[0]-1<0 :
			if grid[n[0]-1] [n[1]] == targetColor:
				grid[n[0]-1][n[1]] = replacementColor
				Q.append([n[0]-1,n[1]])
		if not  n[1]+1>=gridWidth :
			if grid[n[0]] [n[1]+1] == targetColor:
				grid[n[0]][n[1]+1] = replacementColor
				Q.append([n[0],n[1]+1])
		if not n[1]-1<0:
			if grid[n[0]] [n[1]-1] == targetColor:
				grid[n[0]] [n[1]-1] = replacementColor
				Q.append([n[0],n[1]-1])
	return


func fillBoardSlow(x, y, targetColor, replacementColor, grid):
	floodFillSlow(x, y, targetColor, replacementColor, grid)

func floodFillSlow(x, y, targetColor, replacementColor, grid):
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
	
	
	floodFillSlow(x+1, y, targetColor, replacementColor, grid)
	var t1 = Timer.new()
	t1.set_wait_time(speed)
	t1.set_one_shot(true)
	self.add_child(t1)
	t1.start()
	yield(t1, "timeout")
	
	
	floodFillSlow(x-1, y, targetColor, replacementColor, grid)
	var t2 = Timer.new()
	t2.set_wait_time(speed)
	t2.set_one_shot(true)
	self.add_child(t2)
	t2.start()
	yield(t2, "timeout")
	
	
	floodFillSlow(x, y+1, targetColor, replacementColor, grid)
	var t3 = Timer.new()
	t3.set_wait_time(speed)
	t3.set_one_shot(true)
	self.add_child(t3)
	t3.start()
	yield(t3, "timeout")
	
	
	floodFillSlow(x, y-1, targetColor, replacementColor, grid)
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
				$FillTimer.start()
				fillBoardFast(x,y, grid[x][y], pixelGrid[x][y].color, grid)
				$FillTimer.stop()
				#if $ClickTimer.time_left==0:
				#	$ClickTimer.wait_time = (1-$FillTimer.time_left)*10
				#	$ClickTimer.start()
				#fillBoardSlow(x,y, grid[x][y], pixelGrid[x][y].color, grid)
				pixelGrid[x][y].isToggled = false
			pixelGrid[x][y].color = grid[x][y]
			
	$Timer.start()

func _on_ClickTimer_timeout():
	globals.noClicks = false
