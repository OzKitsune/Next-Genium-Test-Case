## Зелье телепортации.
##
## Телепортирует пользователя в случайном направлении на некоторое расстояние.
## Не может телепортировать внутрь физических тел или за пределы невидимых стен.
class_name TeleportationPotion

extends Item

var max_random: int = 80


func apply(player: Player):
	randomize()
	var random_1 = randf_range(-max_random, max_random);
	var random_2 = randf_range(-max_random, max_random);
	var random_position = Vector2(random_1, random_2) + player.global_position
	var space_state = player.get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(player.global_position, random_position)
	var result = space_state.intersect_ray(query)
	if result.is_empty():
		player.global_position = random_position
	else:
		player.global_position = result["position"]
