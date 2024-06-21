extends Node2D

@onready var __tileMap: TileMap = $TileMap
@onready var __sprite: Sprite2D = $Sprite2D
var __direction: Vector2 = Vector2.ZERO
var __sprite_speed = 250

# func _ready() -> void:
# 	get_viewport().canvas_transform.origin = Vector2(200, 200)

func _unhandled_input(event: InputEvent) -> void:
	handle_directional_input()
	if not event is InputEventMouseButton:
		return

	var me: InputEventMouseButton = event
	if me.button_index != MOUSE_BUTTON_LEFT || !me.is_pressed():
		return

	print('position:        ' + str(event.position))
	print('global position: ' + str(event.global_position))

	# print('global_position: ' + str(me.global_position))
	# print('position: ' + str(me.position))

	var tilemap_local_xy = __tileMap.to_local(me.global_position)
	# print('tilemap local: ' + str(tilemap_local_xy))
	var hex_coords = __tileMap.local_to_map(tilemap_local_xy)
	print('tile coords: ' + str(hex_coords))

func _physics_process(delta: float) -> void:
	__sprite.position += delta * __sprite_speed * __direction

func handle_directional_input() -> void:
	__direction = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down').normalized()