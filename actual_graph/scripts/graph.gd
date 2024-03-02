extends Node3D

@export var point_prefab: PackedScene
@export var resolution = 35
var function: FUNCTION = 0
var transitionFunction: FUNCTION = 0
@export var functionDuration = 5
@export var transitionDuration = 2
var transitioning = false
var points = []

enum FUNCTION { SPHERE, TORUS, WAVE, MULTIWAVE, RIPPLE }

func _ready():
	var step = 2.0 / resolution
	var pointScale = Vector3.ONE * step
	points = []  # Initialize as an empty array
	for i in range(resolution * resolution):
		var point = point_prefab.instantiate()
		points.append(point)  # Add each point to the array
		add_child(point)
		point.scale = pointScale

var speed = 1.0
var elapsedTime = 0
var duration = 0
func _process(delta):
	elapsedTime += delta
	duration += delta
	if transitioning:
		if duration >= transitionDuration:
			duration -= transitionDuration
			transitioning = false
	elif duration >= functionDuration:
		duration -= functionDuration
		transitioning = true
		transitionFunction = function
		function = get_next_function(function)

	if transitioning:
		update_function_transition()
	else:
		update_function()
	
func get_next_function(name: FUNCTION):
	if name == FUNCTION.SPHERE:
		name = FUNCTION.TORUS
	elif name == FUNCTION.TORUS:
		name = FUNCTION.WAVE
	elif name == FUNCTION.WAVE:
		name = FUNCTION.MULTIWAVE
	elif name == FUNCTION.MULTIWAVE:
		name = FUNCTION.RIPPLE
	else:
		name = FUNCTION.SPHERE
	return name
	
func morph(u, v, progress):
	var pos1 = do_calculation_v2(u, v, transitionFunction)
	var pos2 = do_calculation_v2(u, v, function)
	return lerp(pos1, pos2, smoothstep(0,1,progress))
	
func update_function_transition():
	var step = 2.0 / resolution
	var i = 0
	var x = 0
	var z = 0
	var v = 0.5 * step - 1.0
	var progress = duration / transitionDuration
	while i < points.size():
		if x == resolution:
			x = 0
			z += 1
			v = (z + 0.5) * step - 1.0
		var u = (x + 0.5) * step - 1.0
		points[i].position = morph(u, v, progress)
		i += 1
		x += 1
		
func update_function():
	var step = 2.0 / resolution
	var i = 0
	var x = 0
	var z = 0
	var v = 0.5 * step - 1.0

	while i < points.size():
		if x == resolution:
			x = 0
			z += 1
			v = (z + 0.5) * step - 1.0
		var u = (x + 0.5) * step - 1.0
		points[i].position = do_calculation_v2(u, v, function)
		i += 1
		x += 1

func do_calculation_v2(u, v, name):
	var pos = Vector3.ZERO
	match name:
		FUNCTION.SPHERE:
			pos = GraphFunctions.sphere(u, v, elapsedTime)
		FUNCTION.TORUS:
			pos = GraphFunctions.torus(u, v, elapsedTime)
		FUNCTION.WAVE:
			pos = GraphFunctions.wave(u, v, elapsedTime)
		FUNCTION.MULTIWAVE:
			pos = GraphFunctions.multiwave(u, v, elapsedTime)
		FUNCTION.RIPPLE:
			pos = GraphFunctions.ripple(u, v, elapsedTime)
	return pos
