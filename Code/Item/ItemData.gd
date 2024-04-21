class_name ItemData

extends Resource

@export var item_script: GDScript
@export var name: String
@export_multiline var description: String
## Будет ли предмет добавляться в инвентарь.
@export var collectable: bool = true
## Можно ли предмет использовать
@export var usable: bool = true
## Будет ли расходоваться предмет при использовании.
@export var consumable: bool = true
@export var image: Texture2D

var path_to_scene: String


func create_item() -> Item:
	var item = item_script.new() as Item
	item.item_data = self
	return item
