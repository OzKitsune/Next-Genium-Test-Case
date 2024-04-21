class_name Location

extends Node

static var states: Dictionary = {}

static var current_location: Location
static var location_where_need_to_close_doors: String = ""

@export var doors_container: Node2D
@export var items_container: Node2D


func _enter_tree():
	load_state()
	current_location = self
	if location_where_need_to_close_doors != "":
		location_where_need_to_close_doors = ""
		close_all_doors()


func _exit_tree():
	save_state()


func load_state():
	if not states.has(name):
		return
		
	var state = states[name]
	
	if doors_container != null:
		for door_node in doors_container.get_children():
			var door = door_node as Door
			door.is_closed = state["Doors"][door.get_index()]
	
	if items_container != null:
		for index in range(items_container.get_child_count() - 1, -1, -1):
			var item = items_container.get_child(index) as SceneItem
			if not state["Items"].has(index):
				item.queue_free()


func save_state():
	## Словарь с информацией о дверях.
	var doors_info: Dictionary = {}
	if doors_container != null:
		for door_node in doors_container.get_children():
			var door = door_node as Door
			doors_info[door.get_index()] = door.is_closed
	
	## Массив индексов предметов, которые остались на сцене.
	var items_info: Array = []
	if items_container != null:
		for item_node in items_container.get_children():
			var item = item_node as SceneItem
			items_info.append(item.start_index)
	
	var state: Dictionary = {
		"Doors" : doors_info,
		"Items" : items_info,
	}
	
	states[name] = state


func close_all_doors() -> void:
	for door_node in doors_container.get_children():
		var door = door_node as Door
		door.is_closed = true


static func close_all_doors_on_location(location_name: String):
	if current_location.name != location_name:
		location_where_need_to_close_doors = location_name
	else:
		current_location.close_all_doors()
