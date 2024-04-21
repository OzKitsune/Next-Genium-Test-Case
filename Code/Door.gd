class_name Door

extends Node2D


@export_category("Параметры двери")
@export_file("*.tscn") var to_scene: String
@export var player_position: Vector2 = Vector2.ZERO
@export var is_closed: bool = true
@export var can_opened_with_key: bool = true

@export_category("Ссылки на узлы")
@export var animated_sprite: AnimatedSprite2D
@export var interaction_area: Area2D
@export var static_body: StaticBody2D


func _on_interaction_area_2d_body_entered(body):
	if body is Player and not is_closed:
		animated_sprite.play("opening")


func _on_interaction_area_2d_body_exited(body):
	if body is Player and not is_closed:
		animated_sprite.play("closing")


func _on_transition_area_2d_body_entered(body):
	if body is Player:
		var player = body as Player
		if is_closed and can_opened_with_key:
			if await player.use_key():
				is_closed = false
				Game.instance.to_location(to_scene, player_position)
		else:
			Game.instance.to_location(to_scene, player_position)
