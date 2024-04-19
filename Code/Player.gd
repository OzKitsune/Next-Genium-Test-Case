class_name Player

extends CharacterBody2D


@export_category("Параметры персонажа")
@export_range(10, 100) var speed: int
@export_range(10, 100) var max_hp: int = 10

var hp: int = max_hp
var keys: int = 0

@export_category("Ссылки на узлы")
@export var interaction_area: Area2D
@export var animation_tree: AnimationTree

@onready var state_machine: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

enum State {IDLE, WALK}
var current_state: State = State.IDLE

var blend_position_paths: Dictionary = {
	State.IDLE : "parameters/idle/idle_bs2d/blend_position",
	State.WALK : "parameters/walk/walk_bs2d/blend_position",
}
var anim_tree_state_keys: Dictionary = {
	State.IDLE : "idle",
	State.WALK : "walk",
}


#func _ready():
	#pass


func _physics_process(_delta):
	move()


func move() -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if input_direction == Vector2.ZERO:
		current_state = State.IDLE
	else:
		current_state = State.WALK
		animation_tree.set(blend_position_paths[State.IDLE], input_direction)
		animation_tree.set(blend_position_paths[State.WALK], input_direction)
	
	state_machine.travel(anim_tree_state_keys[current_state])
	
	move_and_slide()


func add_key() -> void:
	keys += 1
	Globals.hud.set_keys(keys)


func use_key() -> bool:
	if keys == 0:
		return false
	
	keys -= 1
	return true
