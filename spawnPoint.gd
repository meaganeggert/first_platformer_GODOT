extends Node2D

class_name spawnPoint

@export var spawnpoint = false

var activated = false

func activate():
	GameManager.current_spawnPoint = self
	activated = true


func _on_area_2d_area_entered(area):
	if !activated:
		activate()
