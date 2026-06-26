extends Node
class_name Spawner

signal on_obstacle_crash
signal on_player_score

const OBSTACLE_SCENE = preload("uid://btyfpf1mvrwkt") #Referencia a escena obstacle 
@onready var timer: Timer = $Timer #Referencia a un nodo, onready es que se ejecuta al iniciar como _ready
@onready var ground: Ground = $"../Ground"

func spawn_obstacle():
	var obs_instance : Obstacle = OBSTACLE_SCENE.instantiate() 
	obs_instance.player_crashed.connect(_on_player_crashed)
	obs_instance.on_player_scored.connect(_on_player_score)
	
	var viewport : Viewport = get_viewport() 
	# La X la mantenemos igual para que aparezcan justo fuera de la pantalla a la derecha
	obs_instance.position.x = viewport.get_visible_rect().end.x + 150 
	
	# Obtenemos la altura original fija de Project Settings
	var base_height = ProjectSettings.get_setting("display/window/size/viewport_height")
	var half_height = base_height / 2.0 
	
	# (mínimo, máximo) en randf_range
	obs_instance.position.y = randf_range(half_height + 40, half_height + 309)
	
	add_child(obs_instance)
	
func stop_obstacles():
	timer.stop()
	for i :Obstacle in get_children().filter(func(x): return x is Obstacle):
		i.set_speed(0)	
	ground.set_process(false)
	
func _on_player_crashed():
	on_obstacle_crash.emit()
	stop_obstacles()

func _on_timer_timeout() -> void:
	spawn_obstacle()
	
func _on_player_score():
	on_player_score.emit()
	
	
