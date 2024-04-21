## Апельсин.
##
## Увеличивает максимальное здоровье пользователя на 1.
## Увеличивает здоровье пользователя на 1.
class_name Orange

extends Item


func apply(player: Player):
	player.change_max_hp(1)
	player.change_hp(1)
