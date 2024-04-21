class_name ItemStorageControlItem

extends Control

signal selected(inventory_item: ItemStorageControlItem)

@export var background: ColorRect
@export var button: TextureButton

@export var default_texture: Texture2D

var item_data: ItemData
var index: int


func set_item(item: Item) -> void:
	if item == null:
		item_data = null
	else:
		item_data = item.item_data
	if item_data == null:
		button.texture_normal = default_texture;
	else:
		button.texture_normal = item_data.image


func select() -> void:
	background.modulate = Color.DEEP_PINK
	emit_signal("selected", self)


func deselect() -> void:
	background.modulate = Color.WHITE


func _on_texture_button_pressed():
	select()
