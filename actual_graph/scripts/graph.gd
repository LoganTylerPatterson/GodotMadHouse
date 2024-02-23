extends Node3D

@export var point_prefab: PackedScene
@export var resolution = 100

var points = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var step = 2.0 / resolution
	var position = Vector3.ZERO
	var scale = Vector3.ONE * step
	
	for i in range(resolution):
		var point = point_prefab.instantiate()
		points.push_back(point)
		position.x = (i + 0.5) * step - 1.0
		point.position = position
		point.scale = scale
		add_child(point)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
var speed = 1.0
var time = 0
func _process(delta):
	time += delta
	for point in points:
		position = point.position
		position.y = GraphFunctions.multiwave(position.x, time)
		point.position = position
