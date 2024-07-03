class_name GameRules

extends RefCounted

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

func randomize(board: GameBoard, coords: TileCoords) -> GameBoard:
    var new_terrain: Enums.Terrain = Enums.Terrain.values().pick_random()
    board.get_tile(coords).terrain =  new_terrain
    return board