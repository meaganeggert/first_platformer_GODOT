extends Node


var current_spawnPoint : spawnPoint

signal drink_tea(int)
signal gained_heart(int)

var tea : int = 0
var hearts : int = 0

var hasKey : bool = false


var paused = false
var pause_menu

var game_won = false
var win_menu

var start_menu
var controls_menu

var player : Player

func drank_tea(tea_drank):
	tea += tea_drank
	emit_signal("drink_tea", tea_drank)
	#print(tea)
	
func gained_hearts(heart_gained):
	hearts += heart_gained
	if hearts == 15:
		win_game()
	emit_signal("gained_heart", heart_gained)
	#print(tea)
	
func pickedUp_key():
	hasKey = true;
	print_debug(hasKey)
	
func ate_pie():
	player.scale *= 2.5
	
	
func drank_shrink():
	player.scale *= 0.5
	
func back_to_main_level():
	print_debug("You picked up the chest")
	print_debug("Go back to main level")
	
	
func pause_play():
	paused = !paused
	pause_menu.visible = paused
	
func win_game():
	game_won = true
	win_menu.visible = game_won

func resume():
	pause_play()
	
func restart():
	hearts = 0
	tea = 0
	get_tree().reload_current_scene()

func load_menu():
	get_tree().change_scene_to_file("res://levels/level_0.tscn")
	
func load_level0():
	get_tree().change_scene_to_file("res://levels/level_0.tscn")

func hide_start_menu():
	print_debug("hide")
	start_menu.visible = false
	
func show_controls():
	print_debug("controls")
	controls_menu.visible = true
	
func hide_controls():
	print_debug("hide_controls")
	controls_menu.visible = false

func quit():
	get_tree().quit()
	
func respawn_player():
	if spawnPoint != null:
		player.position = current_spawnPoint.global_position
