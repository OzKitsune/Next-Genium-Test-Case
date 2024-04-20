class_name Game

extends Node2D

static var instance: Game

@export var hud: HUD
@export var player: Player

@export var location: Location


func _ready():
	instance = self


func to_location(path_to_scene: String, player_position: Vector2 = Vector2.ZERO) -> void:
	if path_to_scene == "":
		return
	
	if !ResourceLoader.exists(path_to_scene):
		print("Сцена '%s' не существует." % path_to_scene)
		return
		
	if location != null:
		location.queue_free()
	
	location = load(path_to_scene).instantiate()
	call_deferred("add_child", location)
	
	player.position = player_position
