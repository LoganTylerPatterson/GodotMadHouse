extends Node

class HashJob:
	var hashes : PackedInt32Array
	
	func _init(hashes_array: PackedInt32Array):
		hashes = hashes_array
		
	func execute(i: int):
		hashes.set(i, i)
