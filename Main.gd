extends Node2D

var grid = load("res://Grid.tscn").instance()

func _ready():
	add_child(grid)
	#triStripe()
	redHorizontalStripe()
	#randomColor()
	pass 

func _process(delta):
	var complete = false
	for x in range(1,5):
		if checkIfSameColor(x):
			complete = true
			break
	if complete:
		randomColor()
	pass


func checkIfSameColor(color):
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			if grid.grid[x][y] != color:
				return false
	return true

func randomColor(except=0):
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			var color = 1+randi()%4
			while color == except:
				color = 1+randi()%4
			grid.grid[x][y] = color


func triStripe():
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			grid.grid[x][y] = x%4

func redHorizontalStripe():
	randomColor(1)
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			if x%2==0:
				grid.grid[x][y] = 1
				
func yellowHorizontalStripe():
	randomColor()
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			if x%2==0:
				grid.grid[x][y] = 2
				
func redVerticalStripe():
	randomColor()
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			if x%2==0:
				grid.grid[x][y] = 1
				
func yellowVerticalStripe():
	randomColor()
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			if y%2==0:
				grid.grid[x][y] = 2
				
				
				
				
				
				
				
				