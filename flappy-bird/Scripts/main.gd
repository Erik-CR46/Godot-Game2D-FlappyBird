extends Node2D

const SAVE_FILE: String = "user://score.dat"

@onready var spawner: Spawner = $Spawner
@onready var player: Player = $Player
@onready var game_ui: GameUI = $GameUI

var score: int
var max_score: int

func _ready() -> void:
	load_score()

func save_to_file():
	if score > max_score:
		max_score = score
		var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
		file.store_32(max_score)
		
func load_score():
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	if file:
		max_score = file.get_32()

func _on_player_on_game_started() -> void: #Llamamos a la señal on_game_started (se añade player porque viene de esa clase)
	spawner.timer.start()
	game_ui.ocult_start_menu()
	
func _on_spawner_on_obstacle_crash() -> void:
	player.animated_sprite_2d.play("die")
	player.stop_movement()
	
func _on_ground_on_player_crash() -> void:
	player.animated_sprite_2d.play("die_ground")
	spawner.stop_obstacles()
	game_ui.calculate_score(score, max_score)
	game_ui.game_over_panel()


func _on_spawner_on_player_score() -> void:
	score += 1
	game_ui.update_score(score)
	save_to_file()
		
