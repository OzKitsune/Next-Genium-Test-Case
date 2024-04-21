@tool
class_name SceneItem

extends Node2D


var start_index: int 

@export var item_data: ItemData

@export var sprite: Sprite2D
@export var area: Area2D


func _ready():
	sprite.texture = item_data.image
	if not Engine.is_editor_hint():
		start_index = get_index()
		area.body_entered.connect(collect)
		item_data.path_to_scene = scene_file_path


## Подобрать предмет игроком.
func collect(body: Node2D) -> void:
	if body is Player:
		var player = body as Player
		if item_data.collectable:
			if player.inventory.add_item(item_data):
				queue_free()
		else:
			var item = item_data.create_item()
			item.apply(player)
			queue_free()
