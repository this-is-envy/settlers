## MapGen

Explores hex map generation with a tileset.

### Structure

**Misc:**  
- `Data/Enums.gd` &mdash; Bucket for any enums and related utility functions.
- `Data/Utils.gd` &mdash; Bucket for utility functions. Plausibly a bad home and the things here may
  need to be refactored. Atlas/Terrain conversions should be data-driven and live in a config file.

**Core:**  
- `Data/AxialCoords.gd` &mdash; utility functions to handle converting between Godot's Stacked
  coordinate system (even-r) and a more algo-friendly (according to RedBlob) axial system. Pulled
  out into a specific class so that we don't accidentally mix the two coordinate systems by passing
  unspecified `Vector2`s around.
- `Data/Hex.gd` &mdash; Starting point for game tile data model. Currently we only hang the terrain type
  off it. Eventually other attributes/statuses (robber, port, etc) could be folded in fairly trivially.
- `Data/GameBoard.gd` &mdash; Container for all game state data.

**Scenes:**  
- `LevelTemplate.*` &mdash;
- `Game.*` &mdash;