extends CanvasLayer
class_name GameUI

@onready var score_label: Label = %ScoreLabel
@onready var start_menu: Control = $MarginContainer/StartMenu
@onready var game_over_menu: VBoxContainer = %GameOverMenu
@onready var current_score: Label = %CurrentScore
@onready var high_score: Label = %HighScore
@onready var medalimg: TextureRect = %medalimg
@onready var shop_menu: VBoxContainer = %ShopMenu
@onready var coin: Label = %coin

signal buyVegeta

func _ready() -> void:
	score_label.text = "0"

func update_score(value: int):
	score_label.text = str(value)

func calculate_score(score : int, max_score : int):
	current_score.text = str(score)
	high_score.text = str(max_score)
	if score >= 20:
		medalimg.texture = preload("uid://c5q8rpg33holx")
	elif score >= 15:
		medalimg.texture = preload("uid://be7nyiw44n3bu")
	else:
		medalimg.texture = preload("uid://b2akkjgeahful")
		
	
	
func ocult_start_menu():
	start_menu.hide()

func game_over_panel():
	game_over_menu.show()
	score_label.hide()


func _on_play_button_pressed() -> void:
	get_tree().reload_current_scene() #Para recargar la escena que estabamos jugando


func _on_texture_button_pressed() -> void:
	shop_menu.hide()
	game_over_menu.show()


func _on_play_button_3_pressed() -> void:
	shop_menu.show()
	game_over_menu.hide()
	


func _on_buy_vegeta_pressed() -> void:
	buyVegeta.emit()


func _on_buy_gohan_pressed() -> void:
	pass # Replace with function body.


func _on_buy_black_pressed() -> void:
	pass # Replace with function body.


func _on_skins_button_pressed() -> void:
	pass # Replace with function body.
