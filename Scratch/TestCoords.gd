extends Node2D

@onready var __tileMap: TileMap = $TileMap
@onready var __sprite: Sprite2D = $Sprite2D
var __direction: Vector2 = Vector2.ZERO
var __sprite_speed = 250

func _unhandled_input(event: InputEvent) -> void:
	handle_directional_input()
	if not event is InputEventMouseButton:
		return

	var me: InputEventMouseButton = event
	if me.button_index != MOUSE_BUTTON_LEFT || !me.is_pressed():
		return

	# event.global_position returns screen / window (unclear) coordinates and doesn't account
	# for canvas/viewport offset so this attempt to convert to map-local coords doesn't work
	# print('position:        ' + str(event.position))
	# print('global position: ' + str(event.global_position))
	# var tilemap_local_xy = __tileMap.to_local(me.global_position)
	# var hex_coords = __tileMap.local_to_map(tilemap_local_xy)
	# print('tile coords: ' + str(hex_coords))

	# CanvasItem has a call that does the mapping for you however
	var local_xy = __tileMap.get_local_mouse_position()
	# ...which means we can pass that directly to the local->map function
	var hex_coords = __tileMap.local_to_map(local_xy)
	# ...and get rational hex coords out of it
	print('tile coords: ' + str(hex_coords))

func _physics_process(delta: float) -> void:
	__sprite.position += delta * __sprite_speed * __direction

func handle_directional_input() -> void:
	__direction = Input.get_vector('ui_left', 'ui_right', 'ui_up', 'ui_down').normalized()