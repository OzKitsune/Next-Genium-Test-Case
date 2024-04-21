## Оливки.
##
## Уменьшает максимальное здоровье пользователя на 10.
class_name Olives

extends Item


func apply(player: Player):
	player.change_max_hp(-10)
