class_name Player

extends CharacterBody2D

signal died

@export_category("Параметры персонажа")
@export_range(10, 100) var speed: int
@export_range(10, 100) var max_hp: int = 10
@export_range(1, 100) var inventory_size: int = 16

var hp: int = max_hp
var keys: int = 0

var direction_of_view: Vector2

@onready var inventory = ItemStorage.new(inventory_size)

@export_category("Ссылки на узлы")
@export var interaction_area: Area2D
@export var animation_tree: AnimationTree

@onready var state_machine: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

enum State {BLOCK_CONTROL, IDLE, WALK}
var current_state: State = State.IDLE

var blend_position_paths: Dictionary = {
	State.IDLE : "parameters/idle/idle_bs2d/blend_position",
	State.WALK : "parameters/walk/walk_bs2d/blend_position",
}
var anim_tree_state_keys: Dictionary = {
	State.BLOCK_CONTROL : "idle",
	State.IDLE : "idle",
	State.WALK : "walk",
}


func _physics_process(_delta):
	if current_state != State.BLOCK_CONTROL:
		move()
	animate()


func move() -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if input_direction == Vector2.ZERO:
		current_state = State.IDLE
	else:
		current_state = State.WALK
		animation_tree.set(blend_position_paths[State.IDLE], input_direction)
		animation_tree.set(blend_position_paths[State.WALK], input_direction)
		direction_of_view = input_direction
	
	move_and_slide()


func animate() -> void:
	state_machine.travel(anim_tree_state_keys[current_state])


func add_key() -> void:
	keys += 1
	Game.instance.hud.set_keys(keys)


func use_key() -> bool:
	if keys == 0:
		return false
	
	var result = await Game.instance.hud.show_confirm()
	if not result:
		return false
	
	keys -= 1
	Game.instance.hud.set_keys(keys)
	return true


func change_hp(value: int) -> void:
	hp += value
	if hp > max_hp:
		hp = max_hp
	if hp < 0:
		hp = 0
		emit_signal("died")
	Game.instance.hud.set_hp(hp, max_hp)


## Изменить максимальное здоровье на указанное значение.
func change_max_hp(value: int) -> void:
	max_hp += value
	if max_hp < 1:
		max_hp = 1
	if hp > max_hp:
		hp = max_hp
	Game.instance.hud.set_hp(hp, max_hp)


func get_position_in_front() -> Vector2:
	return position + direction_of_view * 25
