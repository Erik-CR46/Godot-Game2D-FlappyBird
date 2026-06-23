extends Node2D

const SAVE_FILE: String = "user://save.json"

@onready var spawner: Spawner = $Spawner
@onready var player: Player = $Player
@onready var game_ui: GameUI = $GameUI
@onready var fondo: AudioStreamPlayer = $Fondo

var score: int
var max_score: int
var skins = ["goku"]
var coins: int
var skin_actual: String = "goku"

var skin_frames = {
	"goku": preload("uid://cqlf3r67ks0ro"),
	"vegeta": preload("uid://ccesft4h772i0"),
	"gohan": preload("uid://bl7b0hjc6nw47"),
	"black": preload("uid://b7sol3u8mp2kl")
}

func _ready() -> void:
	fondo.play()
	load_score()
	game_ui.coin.text = str(coins)
	player.animated_sprite_2d.sprite_frames = skin_frames[skin_actual]
	_on_game_ui_update_skins()

func save_to_file():
	if score > max_score:
		max_score = score
	
	var data = {
		"max_score" : max_score,
		"coins" : coins,
		"skin_actual" : skin_actual,
		"skins" : skins
	}
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
		
func load_score():
	if !FileAccess.file_exists(SAVE_FILE):
		max_score = 0
		coins = 0
		skins = ["goku"]
		return
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	
	if file:
		max_score = data.get("max_score", 0)
		coins = data.get("coins", 0)
		skin_actual = str(data.get("skin_actual", "goku"))
		skins = data.get("skins", ["goku"])
		if typeof(skins) != TYPE_ARRAY:
			skins = ["goku"]

func _on_player_on_game_started() -> void: #Llamamos a la señal on_game_started (se añade player porque viene de esa clase)
	spawner.timer.start()
	game_ui.ocult_start_menu()
	
func _on_spawner_on_obstacle_crash() -> void:
	player.animated_sprite_2d.play("die")
	player.golpe.play()
	player.stop_movement()
	
func _on_ground_on_player_crash() -> void:
	player.animated_sprite_2d.play("die_ground")
	player.golpe.play()
	spawner.stop_obstacles()
	game_ui.calculate_score(score, max_score)
	game_ui.game_over_panel()


func _on_spawner_on_player_score() -> void:
	score += 1
	coins += 1
	game_ui.update_score(score)
	game_ui.coin.text = str(coins)
	save_to_file()

func _on_game_ui_buy_vegeta() -> void:
	if "vegeta" in skins:
		return
	if coins < 50:
		return
	else:
		coins -= 50
		game_ui.coin.text = str(coins)
		skins.append("vegeta")
		save_to_file()
		
func _on_game_ui_select_vegeta() -> void:
	equip_skin("vegeta")

func _on_game_ui_select_goku() -> void:
	equip_skin("goku")

func equip_skin(nombre: String):
	if not skin_frames.has(nombre):
		return
	skin_actual = nombre
	player.animated_sprite_2d.sprite_frames = skin_frames[nombre]
	save_to_file()


func _on_game_ui_buy_gohan() -> void:
	if "gohan" in skins:
		return
	if coins < 150:
		return
	else:
		coins -= 150
		game_ui.coin.text = str(coins)
		skins.append("gohan")
		save_to_file()
		
func _on_game_ui_update_skins() -> void:
	if "goku" in skins:
		game_ui.gokuSkinMenu.show()
	if "vegeta" in skins:
		game_ui.vegetaSkinMenu.show()
	if "gohan" in skins:
		game_ui.gohanSkinMenu.show()
	if "black" in skins:
		game_ui.blackSkinMenu.show()

func _on_game_ui_select_gohan() -> void:
	equip_skin("gohan")


func _on_game_ui_buy_black() -> void:
	if "black" in skins:
		return
	if coins < 200:
		return
	else:
		coins -= 200
		game_ui.coin.text = str(coins)
		skins.append("black")
		save_to_file()

func _on_game_ui_select_black() -> void:
	equip_skin("black")
