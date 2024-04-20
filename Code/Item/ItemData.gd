class_name ItemData

extends Resource

@export var item_script: GDScript
@export var title: String
@export var description: String
## Будет ли предмет добавляться в инвентарь.
@export var collectable: bool = true
## Будет ли расходоваться предмет при использовании.
@export var consumable: bool = true
@export var image: Texture2D
