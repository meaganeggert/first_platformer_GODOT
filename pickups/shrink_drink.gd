extends Area2D

func _on_area_entered(area):
	GameManager.drank_shrink()
	$audio_drink.play()
	queue_free()
