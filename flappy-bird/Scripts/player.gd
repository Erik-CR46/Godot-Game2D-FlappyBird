extends CharacterBody2D

@export var gravity := 1000.0
@export var jump_force := 400.0
@export var max_speed := 400.0
@export var rotation_speed := 2.0

func _physics_process(delta: float) -> void: #Se ejecuta cada x frames, se utiliza para implementar una logica de juego
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, max_speed ) #La funcion min se queda con el valor mas pequeño
	#La utilizamos para que velocity no supere nunca la max_speed, porque mientras avanza el juego velocity va subiendo
	
	if Input.is_action_just_pressed("jump"):
		jump()
	
	move_and_slide() #Cada vez que se ejecuta lee todos los cambios que le hicimos a velocity
	rotate_player()
	
func jump():
	velocity.y = -jump_force
	rotation = deg_to_rad(-30)

func rotate_player():
	if velocity.y > 0 and rad_to_deg(rotation) < 80:
		rotation += rotation_speed * deg_to_rad(1)
		
