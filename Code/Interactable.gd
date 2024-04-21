extends Node


@export_multiline var message: String
@export var sprite: Sprite2D

var default_modulate: Color
var player_inside: bool = false


func _ready():
	default_modulate = sprite.modulate


func _input(event):
	if player_inside and event.is_action_pressed("action"):
		Game.instance.hud.show_message(message)


func _on_area_2d_body_entered(body):
	if body is Player:
		player_inside = true
		sprite.modulate = Color.BLANCHED_ALMOND 


func _on_area_2d_body_exited(body):
	if body is Player:
		player_inside = false
		sprite.modulate = default_modulate
