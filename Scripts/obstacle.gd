extends Node2D
class_name Obstacle
@export var move_speed := 150.0
signal player_crashed #Aqui creamos la señal
signal on_player_scored #Nueva señal para emitir cuando entre en la zona


func _process(delta: float) -> void: #Es para actualizar cosas que no estan relacionadas a la fisica, aqui solo queremos ir moviendo la posicion, nada de gravedad
	position.x -= move_speed * delta
	
func set_speed(value : float):
	move_speed = value

func _on_area_body_entered(body: Node2D) -> void: #Esta funcion es de textarea que recibe el nodo que ha entrado en el area
	player_crashed.emit() #Aqui emitimos la señal


func _on_visible_on_screen_notifier_2d_screen_exited() -> void: #Señal que viene del mismo VisibleOnScreen
	queue_free()


func _on_score_area_body_entered(body: Node2D) -> void:
	on_player_scored.emit()
	
