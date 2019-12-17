extends Node2D

#var grid = load("res://Grid.tscn").instance()
onready var grid = get_node("Grid")
func _ready():
	#add_child(grid)
	#twoStripe()
	#triStripe()
	#redHorizontalStripe()
	#randomColor()
	$AnimationPlayer.play("fadein")
	newPattern(globals.completeCount)
	pass 

func _process(delta):
	var complete = false
	for x in range(1,5):
		if checkIfSameColor(x):
			complete = true
			break
	if complete:
		globals.completeCount += 1
		globals.noClicks = true
		yield(get_tree().create_timer(1), "timeout")
		globals.noClicks = false
		newPattern(globals.completeCount)
		complete = false
		get_tree().change_scene("res://Main.tscn")
	pass

func newPattern(c):
			
	c = c%10
	if c == 0:
		twoStripe()
	elif c == 1:
		triStripe()
	elif c == 2:
		fourStripe()
	elif c == 3:
		yellowVerticalStripe()
	elif c == 4:
		redVerticalStripe()
	elif c == 5:
		redHorizontalStripe()
	else:
		randomColor(randi()%5)


func checkIfSameColor(color):
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			if grid.grid[x][y] != color:
				return false
	return true

func randomColor(except=0):
	randomize()
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			var color = 1+randi()%4
			while color == except:
				color = 1+randi()%4
			grid.grid[x][y] = color

func twoStripe():
	#randomColor(1)
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			grid.grid[x][y] = 1+(x%2)

func triStripe():
	#randomColor(1)
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			grid.grid[x][y] = 1+x%3

func fourStripe():
	#randomColor(1)
	for x in range(grid.gridHeight):
		for y in range(grid.gridWidth):
			grid.grid[x][y] = 1+x%4

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
				
				
				
				
				
				
				
				