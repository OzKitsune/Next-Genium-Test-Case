class_name Door

extends Node2D


@export_category("Параметры двери")
@export_file("*.tscn") var to_scene: String
@export var player_position: Vector2 = Vector2.ZERO
@export var closed: bool = true
@export var can_opened_with_key: bool = true
@export var inside: bool = false

@export_category("Ссылки на узлы")
@export var animated_sprite: AnimatedSprite2D
@export var interaction_area: Area2D
@export var static_body: StaticBody2D


func _ready():
	## Если за дверью ничего нет, её нужно закрыть и убрать возможность открывать.
	if to_scene == "":
		set_door_status(true, false)
	else:
		set_door_status(closed, can_opened_with_key)


func _on_interaction_area_2d_body_entered(body):
	if body is Player and (not closed or inside):
		animated_sprite.play("opening")


func _on_interaction_area_2d_body_exited(body):
	if body is Player and (not closed or inside):
		animated_sprite.play("closing")


func _on_transition_area_2d_body_entered(body):
	if body is Player:
		var player = body as Player
		if inside or not closed:
			Game.instance.to_location(to_scene, player_position)
		elif closed and can_opened_with_key:
			if await player.use_key():
				closed = false
				Game.instance.to_location(to_scene, player_position)


func set_door_status(is_closed: bool, can_opened: bool):
	closed = is_closed
	can_opened_with_key = can_opened
	if closed:
		animated_sprite.play("close")
	else:
		animated_sprite.play("closing")
