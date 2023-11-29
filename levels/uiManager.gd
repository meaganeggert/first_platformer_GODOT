extends CanvasLayer

func _ready():
	GameManager.pause_menu = $pauseMenu
	GameManager.gained_heart.connect(update_hearts_display)
	GameManager.win_menu = $winMenu
	GameManager.start_menu = $startMenu
	GameManager.controls_menu = $controlsMenu

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		GameManager.pause_play()

func update_hearts_display(gained_coins):
	$heartDisplay.text = str(GameManager.hearts)

func _on_resume_button_pressed():
	GameManager.resume()

func _on_restart_button_pressed():
	GameManager.restart()

func _on_menu_button_pressed():
	GameManager.load_menu()

func _on_quit_button_pressed():
	GameManager.quit()


func _on_start_button_pressed():
	GameManager.hide_start_menu()


func _on_controls_button_pressed():
	GameManager.show_controls()


func _on_go_back_button_pressed():
	GameManager.hide_controls()
