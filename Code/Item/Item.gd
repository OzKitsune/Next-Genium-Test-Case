class_name Item

extends RefCounted 


var item_data: ItemData


func apply(_player: Player):
	pass


func drop(_sender: Node, position: Vector2):
	var item_scene = ResourceLoader.load(item_data.path_to_scene) as PackedScene
	var item = item_scene.instantiate() as Node2D
	Game.instance.location.add_child(item)
	item.position = position
