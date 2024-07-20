extends Node3D

var HashJob = "res://code/hash_job.gd"

func visualize_hashes(num_hashes: int):
	var hashes = PackedInt32Array()
	hashes.resize(num_hashes)
	
	var job = HashJob.new(hashes)
	
	for i in range(num_hashes):
		job.execute(i)
		
	return hashes
	
func _ready():
	var num_hashes = 10
	var hashes = visualize_hashes(num_hashes)
	
	for i in range(num_hashes):
		print("Hash[", i, "]: ", hashes.get(i))
