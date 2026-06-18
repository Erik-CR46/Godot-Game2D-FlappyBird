extends Node2D
@onready var spawner: Spawner = $Spawner
@onready var player: Player = $Player


func _on_player_on_game_started() -> void: #Llamamos a la señal on_game_started (se añade player porque viene de esa clase)
	spawner.timer.start()
	
func _on_spawner_on_obstacle_crash() -> void:
	player.stop_movement()
	
func _on_ground_on_player_crash() -> void:
	spawner.stop_obstacles()
