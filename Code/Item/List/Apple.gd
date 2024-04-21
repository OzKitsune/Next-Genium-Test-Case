## Яблоко.
##
## Увеличивает здоровье пользователя на 1.
class_name Apple

extends Item


func apply(player: Player):
	player.change_hp(1)
