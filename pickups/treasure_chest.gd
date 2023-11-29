extends Area2D




func _on_area_entered(area):
	GameManager.back_to_main_level()
	$audio_treasure.play()
	queue_free()

