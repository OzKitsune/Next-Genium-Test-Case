## Амулет.
##
## Уменьшает здоровье пользователя на 9. увеличивает максимальное здоровье пользователя на 1.
## Не расходуется при использовании.
class_name Amulet

extends Item


func apply(player: Player):
	player.change_hp(-9)
	player.change_max_hp(1)
