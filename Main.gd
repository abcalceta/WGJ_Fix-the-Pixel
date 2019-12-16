extends Node2D

var grid = load("res://Grid.tscn").instance()

func _ready():
	add_child(grid)
	#triStripe()
	redHorizontalStripe()
	pass 

func _process(delta):
	pass

func triStripe():
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			grid.grid[x][y] = x%3

func redHorizontalStripe():
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			if x%2==0:
				grid.grid[x][y] = 1
				
func yellowHorizontalStripe():
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			if x%2==0:
				grid.grid[x][y] = 2
				
func redVerticalStripe():
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			if x%2==0:
				grid.grid[x][y] = 1
				
func yellowVerticalStripe():
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			if y%2==0:
				grid.grid[x][y] = 2
				
				
				
				
				
				
				
				