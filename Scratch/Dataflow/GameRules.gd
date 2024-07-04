class_name GameRules
extends RefCounted

var _turn: int = 0
var _phase: Enums.TurnPhase

var _board: GameBoard
var _display: BoardDisplay
var _desert_btn: Button
var _grass_btn: Button
var _label: Label
var _placing_terrain: Enums.Terrain

signal _terrain_selected()

func _init(_ui: CanvasLayer, display: BoardDisplay, board: GameBoard) -> void:
    _board = board
    _display = display

    _desert_btn = _ui.get_node("DesertButton")
    _desert_btn.pressed.connect(_on_desert_clicked)
    _grass_btn = _ui.get_node("GrassButton")
    _grass_btn.pressed.connect(_on_grass_clicked)
    _label = _ui.get_node("PhaseLabel")
    _placing_terrain = Enums.Terrain.ALLOCATE

    _phase = Enums.TurnPhase.RandomizeTerrain
    _setup_phase_ui()
    _do_phase()

func _setup_phase_ui() -> void:
    match _phase:
        Enums.TurnPhase.RandomizeTerrain:
            _setup_randomize()
        Enums.TurnPhase.PlaceTerrain:
            _setup_place_terrain()

func _setup_randomize() -> void:
    print('_setup_randomize()')
    _label.text = "Select a tile to randomize_tile"
    _desert_btn.visible = false
    _grass_btn.visible = false
    _placing_terrain = Enums.Terrain.ALLOCATE

func _setup_place_terrain() -> void:
    print('_setup_place_terrain()')
    _desert_btn.visible = true
    _grass_btn.visible = true
    if _placing_terrain == Enums.Terrain.ALLOCATE:
        _label.text = "Select a terain type to place."
    else:
        _label.text = "Select a hex to convert to " + Enums.TerrainName(_placing_terrain)

func _do_phase() -> void:
    var next_phase: Enums.TurnPhase
    match _phase:
        Enums.TurnPhase.RandomizeTerrain:
            var tile := await _display.get_selected_tile()
            randomize_tile(_board, tile)
            next_phase = Enums.TurnPhase.PlaceTerrain
        Enums.TurnPhase.PlaceTerrain:
            await _terrain_selected
            var tile := await _display.get_selected_tile()
            place(_board, tile, _placing_terrain)
            next_phase = Enums.TurnPhase.RandomizeTerrain

    _display.update(_board)
    _phase = next_phase
    _setup_phase_ui()
    _do_phase()

func _on_desert_clicked() -> void:
    _placing_terrain = Enums.Terrain.DESERT
    _terrain_selected.emit()

func _on_grass_clicked() -> void:
    _placing_terrain = Enums.Terrain.GRASS
    _terrain_selected.emit()

func can_place(board: GameBoard, coords: TileCoords, new_terrain: Enums.Terrain) -> bool:
    var tile := board.get_tile(coords)
    if tile == null:
        printerr("Invalid coords pased to placement function.")
        return false
    return new_terrain != tile.terrain

func place(board: GameBoard, coords: TileCoords, new_terrain: Enums.Terrain) -> GameBoard:
    var tile := board.get_tile(coords)
    tile.terrain = new_terrain
    return board

const RANDOM_TILES: Array[Enums.Terrain] = [Enums.Terrain.CONCRETE, Enums.Terrain.DESERT, Enums.Terrain.GRASS]
func randomize_tile(board: GameBoard, coords: TileCoords) -> GameBoard:
    var new_terrain: Enums.Terrain = RANDOM_TILES.pick_random()
    board.get_tile(coords).terrain =  new_terrain
    return board