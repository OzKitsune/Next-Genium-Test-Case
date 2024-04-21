## Класс для взаимодействия с хранилищем предметов ItemStorage.
class_name ItemStorageControl

extends Control

signal item_selected(item: Item)

@export var items_container: Container
@export var buttons_container: Container
@export var item_name_text_label: RichTextLabel
@export var item_desc_text_label: RichTextLabel

@export var inventory_item_prefab: PackedScene


const EMPTY_NAME_TEXT = "Пусто"
const EMPTY_DESC_TEXT = "Пустая ячейка"


var item_storage: ItemStorage

var buttons: Array[Button] = []

var selected_item: ItemStorageControlItem
var selected_index: int


func set_item_storage(value: ItemStorage) -> void:
	if item_storage != null:
		item_storage.item_added.disconnect(update)
		item_storage.item_removed.disconnect(update)
		item_storage.size_changed.disconnect(update)
	
	selected_index = -1
	item_storage = value
	
	item_storage.item_added.connect(update)
	item_storage.item_removed.connect(update)
	item_storage.size_changed.connect(update)
	
	update()


func create_slots() -> void:
	clear_slots()
	if item_storage != null:
		for index in item_storage.number_of_slots:
			add_slot(item_storage.items[index], index) 


func add_slot(item: Item, index: int) -> void:
	var inventory_item = inventory_item_prefab.instantiate() as ItemStorageControlItem
	items_container.add_child(inventory_item)
	inventory_item.set_item(item)
	inventory_item.index = index
	inventory_item.selected.connect(select_item)


func clear_slots() -> void:
	for item in items_container.get_children():
		item.queue_free()


## Полностью обновить инвентарь в соответсвии с item_storage.
func update() -> void:
	selected_item = null
	create_slots()
	
	await get_tree().process_frame ## Ожидание, чтобы корректно выбрать только что созданный слот. 
	if selected_index >-1 and selected_index < items_container.get_child_count():
		var inventory_item = items_container.get_child(selected_index) as ItemStorageControlItem
		inventory_item.select()
	else:
		show_nothing()


func select_item(inventory_item: ItemStorageControlItem) -> void:
	if selected_item != null and selected_item != inventory_item:
		selected_item.deselect()
	
	selected_item = inventory_item
	selected_index = inventory_item.index
	
	if selected_item.item_data == null:
		show_nothing()
	else:
		item_name_text_label.text = selected_item.item_data.name
		item_desc_text_label.text = selected_item.item_data.description
		enable_buttons()
	
	emit_signal("item_selected", get_selected_item())


func add_button(text: String) -> Button:
	var button = Button.new()
	button.text = text
	buttons_container.add_child(button)
	buttons.append(button)
	return button


func clear_buttons() -> void:
	for button in buttons_container.get_children():
		button.queue_free()


func get_selected_item() -> Item:
	if selected_item == null or selected_item.item_data == null:
		return null
	return item_storage.items[selected_item.index]


func show_nothing() -> void:
	item_name_text_label.text = EMPTY_NAME_TEXT
	item_desc_text_label.text = EMPTY_DESC_TEXT
	disable_buttons()


func disable_buttons() -> void:
	for button: Button in buttons_container.get_children():
		button.disabled = true


func enable_buttons() -> void:
	for button: Button in buttons_container.get_children():
		button.disabled = false


func deselect() -> void:
	selected_index = -1
	show_nothing()
