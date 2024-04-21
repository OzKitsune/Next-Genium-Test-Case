## Класс хранилище предметов.
##
## Модель данных, предназначенная для хранения упорядоченного набора предметов.
## Минимальный размер хранилища - 1.
class_name ItemStorage

extends Object

signal item_added()
signal item_removed()
signal size_changed()

var number_of_slots: int
var items: Array[Item] = []


func _init(slots: int):
	if slots < 1:
		slots = 1
	
	number_of_slots = slots
	items.resize(slots)


## Добавить предмет в первую свободную ячейку, если это возмозжно.
## В случае успеха возвращает true.
func add_item(item: ItemData) -> bool:
	var index = items.find(null)
	if index == -1: ## Если в массиве нет null, значит все ячейки заняты.
		return false
	
	items[index] = item.create_item()
	emit_signal("item_added")
	return true


## Извлечь предмет из указанной ячейки.
func extract_item(slot_index: int) -> Item:
	var item =  items.pop_at(slot_index)
	items.resize(number_of_slots)
	emit_signal("item_removed")
	return item
