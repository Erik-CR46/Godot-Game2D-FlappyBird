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
@onready var skins_menu: VBoxContainer = %SkinsMenu
@onready var vegetaSkinMenu: VBoxContainer = $MarginContainer/SkinsMenu/Panel/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer2
@onready var gokuSkinMenu: VBoxContainer = $MarginContainer/SkinsMenu/Panel/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer
@onready var gohanSkinMenu: VBoxContainer = $MarginContainer/SkinsMenu/Panel/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer3
@onready var blackSkinMenu: VBoxContainer = $MarginContainer/SkinsMenu/Panel/MarginContainer/VBoxContainer/VBoxContainer4

signal updateSkins

signal buyVegeta
signal buyGohan
signal buyBlack

signal selectGoku
signal selectVegeta
signal selectGohan
signal selectBlack

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
	skins_menu.hide()
	game_over_menu.show()


func _on_play_button_3_pressed() -> void:
	shop_menu.show()
	game_over_menu.hide()
	


func _on_buy_vegeta_pressed() -> void:
	buyVegeta.emit()
	updateSkins.emit()
	


func _on_buy_gohan_pressed() -> void:
	buyGohan.emit()
	updateSkins.emit()


func _on_buy_black_pressed() -> void:
	buyBlack.emit()
	updateSkins.emit()


func _on_skins_button_pressed() -> void:
	skins_menu.show()
	game_over_menu.hide()


func _on_select_vegeta_pressed() -> void:
	selectVegeta.emit()


func _on_select_goku_pressed() -> void:
	selectGoku.emit()



func _on_select_gohan_pressed() -> void:
	selectGohan.emit()


func _on_select_black_pressed() -> void:
	selectBlack.emit()
