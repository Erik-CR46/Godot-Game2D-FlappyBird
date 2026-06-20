extends CharacterBody2D
class_name Player
signal on_game_started #Creamos una señal de que el juego empieza
@export var gravity := 1000.0
@export var jump_force := 400.0
@export var max_speed := 400.0
@export var rotation_speed := 2.0
var is_started = false
var should_proces_input = true
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.play("fly")

func _physics_process(delta: float) -> void: #Se ejecuta cada x frames, se utiliza para implementar una logica de juego
	if Input.is_action_just_pressed("jump") and should_proces_input:
		if is_started == false:
			is_started = true
			on_game_started.emit() #Si presiona jump y y el booleano es false, started es false emitimos la señal de que el juego ha empezado
		jump()
	 
	if is_started == false:
		return
	
	
	velocity.y += gravity * delta
	velocity.y = min(velocity.y, max_speed ) #La funcion min se queda con el valor mas pequeño
	#La utilizamos para que velocity no supere nunca la max_speed, porque mientras avanza el juego velocity va subiendo
	
	
	
	move_and_slide() #Cada vez que se ejecuta lee todos los cambios que le hicimos a velocity
	#rotate_player()
	
func jump():
	animated_sprite_2d.play("jump")
	velocity.y = -jump_force
	#rotation = deg_to_rad(-30)

#func rotate_player():
	#if velocity.y > 0 and rad_to_deg(rotation) < 80:
		#rotation += rotation_speed * deg_to_rad(1)

func stop_movement():
	should_proces_input = false

func stop_gravity():
	gravity = 0
	velocity = Vector2.ZERO
