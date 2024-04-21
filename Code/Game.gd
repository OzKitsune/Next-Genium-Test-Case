class_name Game

extends Node2D

static var instance: Game

@export var hud: HUD
@export var player: Player

@export var location: Location


func _ready():
	instance = self
	hud.inventory.item_storage_control.set_item_storage(player.inventory)


func _input(event):
	if event.is_action_pressed("inventory"):
		change_inventory_visibility()


func change_inventory_visibility() -> void:
	hud.inventory.visible = !hud.inventory.visible
	if hud.inventory.visible:
		player.current_state = player.State.BLOCK_CONTROL
	else:
		player.current_state = player.State.IDLE


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
