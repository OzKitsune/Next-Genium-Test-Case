## Зелье сигнализации.
##
## Запирает все открытые дома на улице.
class_name AlarmPotion

extends Item


func apply(_player: Player):
	Location.close_all_doors_on_location("Street")
