## MapGen

Explores board generation with distinct data and render nodes.

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
- `LevelTemplate.*` &mdash; Defines the structure of a level using stub tiles that indicate what
  should be randomly assigned. Produces a `GameBoard` with the initial templated state for level
  generation and can true itself to a visual representation of the board via `reify`. Roughly this
  is a view for the state of the game.
- `Game.*` &mdash; driver that maps input to board generation + binding a level template into a
  playable UI.

### Thoughts

The `LevelTemplate.reify` setup makes for a workable separation of concerns and lets us fully remove
game data from the logic of rendering it.

In a situation where you're dealing with a {highly dynamic environment, a real-time game, or potentially
even just a large number of components} it wouldn't work as currently prototyped as too much work would
need to be re-done on each `_process` pass to sort out what components are dirty. For a fairly stationary
turn-based game though it seems reasonable.

The benefits in my mind are roughly:
- Game logic can act fully on a GameBoard and be tested without UI wiring/stubs needed
- Game state can be saved and loaded using the same logic that we use for every draw cycle

### Concerns

- This is functionally not that different from "we have a scene that has a tilemap" and it's not
  obvious without additional experimentation how much benefit there is vs Just Not Being Clever.
- Currently GameBoard owns initialization which is somewhat constricting; it's likely we'll want
  to let a level template (or something, maybe resources that be configured via pre/replace/post
  hooks to override default behaviors).
- There are some hard coded assumptions about Tilesets and the mapping to atlas coords in code is
  ass. Fine for prototying and probably even functional for a long bit of development but eventually
  I expect we'll want to switch to something bound to the level template or formalize a set of
  assumptions / method to extend the default tileset.

### Next Steps

Take this and see what a full UI -> player action -> game action -> feedback -> repeat feels like.