class_name HUD

extends CanvasLayer

signal confirm_window_was_closed(result: bool)

@export var hp_text_label: RichTextLabel
@export var keys_text_label: RichTextLabel

@export var message_text_label: RichTextLabel
@export var message_player: AnimationPlayer

@export var inventory: Inventory

@export var confirmation_dialog: ConfirmationDialog


const HP_TEXT: String = "HP %s / %s"
const KEYS_TEXT: String = "Ключи: %s"
const MESSAGE_TEXT: String = "[center]%s"


func set_hp(hp: int, max_hp: int) -> void:
	hp_text_label.text = HP_TEXT % [hp, max_hp]


func set_keys(number: int) -> void:
	keys_text_label.text = KEYS_TEXT % number


func show_message(text: String) -> void:
	message_text_label.text = MESSAGE_TEXT % text
	message_player.play("RESET")
	message_player.play("show")


func show_confirm() -> bool:
	Game.instance.block_player_control(true)
	confirmation_dialog.show()
	var result = await confirm_window_was_closed
	Game.instance.block_player_control(false)
	return result


func _on_confirmation_dialog_canceled():
	emit_signal("confirm_window_was_closed", false)


func _on_confirmation_dialog_confirmed():
	emit_signal("confirm_window_was_closed", true)
