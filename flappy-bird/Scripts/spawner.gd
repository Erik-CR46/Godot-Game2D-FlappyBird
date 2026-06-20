extends Node
class_name Spawner

signal on_obstacle_crash
signal on_player_score

const OBSTACLE_SCENE = preload("uid://btyfpf1mvrwkt") #Referencia a escena obstacle 
@onready var timer: Timer = $Timer #Referencia a un nodo, onready es que se ejecuta al iniciar como _ready
@onready var ground: Ground = $"../Ground"

func spawn_obstacle():
	var obs_instance : Obstacle = OBSTACLE_SCENE.instantiate() #Esto crea una instancia 
	obs_instance.player_crashed.connect(_on_player_crashed)#Cada vez que instanciemos un objeto, en la clase obstacle
	#emite la funcion player_crashed que el funcionamiento esta en obstacle, despues conectamos a la funcion de aqui
	#para que haga dicho funcionamiento
	obs_instance.on_player_scored.connect(_on_player_score)
	
	var viewport : Viewport = get_viewport() #Para obtener la pantalla
	obs_instance.position.x = viewport.get_visible_rect().end.x + 150 #Nos regresa la posicion global del viewport
	#.end para posicionarlo al final del viewport y le sumamos 150 para dejar un margen
	
	var half_height = viewport.size.y / 2 #Cuando restas la posicion sube pa arriba, sumar al reves
	obs_instance.position.y = randf_range(half_height + 309, half_height + 40)
	add_child(obs_instance) #Pero ahora hay que darle un padre, para que pertenezca a nuestra escena de spawner
	
	
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
	
	
