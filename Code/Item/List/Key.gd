## Ключ.
##
## Увеличивает количество ключей пользователя на 1.
class_name Key

extends Item


func apply(player: Player):
	player.add_key()
