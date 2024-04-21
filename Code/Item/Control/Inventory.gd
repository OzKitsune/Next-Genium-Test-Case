## Класс для управления инвентарём игрока.
class_name Inventory

extends Control


@export var item_storage_control: ItemStorageControl

var use_button: Button
var drop_button: Button


func _ready():
	item_storage_control.item_selected.connect(item_was_selected)
	
	use_button = item_storage_control.add_button("Использовать")
	drop_button = item_storage_control.add_button("Выбросить")
	
	use_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	drop_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	use_button.pressed.connect(use_item)
	drop_button.pressed.connect(drop_item)


func item_was_selected(item: Item) -> void:
	if item == null:
		return
	use_button.disabled = not item.item_data.usable


func use_item() -> void:
	var item = item_storage_control.get_selected_item()
	if item == null:
		return
	if item.item_data.consumable:
		item_storage_control.item_storage.extract_item(item_storage_control.selected_index)
		item_storage_control.deselect()
	item.apply(Game.instance.player)


func drop_item() -> void:
	var item = item_storage_control.get_selected_item()
	if item == null:
		return
	item_storage_control.item_storage.extract_item(item_storage_control.selected_index)
	item.drop(Game.instance.player, Game.instance.player.get_position_in_front())
	item_storage_control.deselect()
