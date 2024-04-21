## Перец чили.
##
## Уменьшает здоровье пользователя на 1.
class_name Chilli

extends Item


func apply(player: Player):
	player.change_hp(-1)
