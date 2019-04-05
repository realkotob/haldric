extends Control

onready var tween := $Tween
onready var anim := $AnimationPlayer as AnimationPlayer
onready var camera := $Camera2D as Camera2D

onready var campaigns := $ChooseCampaign as Control
onready var singleplayer := $ChooseScenario as Control
onready var options := $Options as Control
onready var lobby := $Lobby as Control

func _ready() -> void:
	get_tree().connect("screen_resized", self, "_on_screen_resized")
	Audio.play(Registry.music.return_to_wesnoth)
	$Version.text = Global.version_string
	_on_screen_resized()
	_on_Menu_pressed()

func _move_camera_to(new_position: Vector2) -> void:
	$TopMenu/TitleMenuBar.visible = true
	tween.interpolate_property(camera, "position", camera.position, new_position, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

func _on_Singleplayer_pressed() -> void:
	_move_camera_to(singleplayer.rect_position)
	#Scene.change(Scene.ChooseScenario)

func _on_Menu_pressed():
	$Menu.show()
	_move_camera_to(Vector2(0, 0))
	$TopMenu/TitleMenuBar.visible = false

func _on_Campaigns_pressed() -> void:
	print("Campaigns pressed")
	_move_camera_to(campaigns.rect_position)
	campaigns.animate()

func _on_ChooseCampaign_back() -> void:
	_move_camera_to(Vector2(0, 0))

func _on_Lobby_pressed() -> void:
	_move_camera_to(lobby.rect_position)

func _on_Lobby_back() -> void:
	_move_camera_to(Vector2(0, 0))

func _on_Editor_pressed() -> void:
	Scene.change(Scene.Editor)

func _on_Options_pressed() -> void:
	_move_camera_to(options.rect_position)
	# Scene.change(Scene.Options)

func _on_Quit_pressed() -> void:
	get_tree().quit()

func _on_screen_resized() -> void:
	var size : Vector2 = get_viewport().size
	lobby.rect_position = Vector2(0, -size.y)
	campaigns.rect_position = Vector2(-size.x, 0)
	singleplayer.rect_position = size
	options.rect_position = Vector2(0, size.y)


