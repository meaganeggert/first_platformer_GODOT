extends Area2D

func _on_area_entered(area):
	GameManager.ate_pie()
	$audio_food.play()
	queue_free()
