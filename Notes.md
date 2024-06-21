# Resources and Notes

## Catan
- [Rules](https://www.catan.com/understand-catan/game-rules) &mdash; Full collection of all the rules.
  Includes base game and all expansions.

## Hex Maps
- [godot-hexgrid](https://github.com/jeremyz/godot-hexgrid) &mdash; Some hex algos implemented in
  gdscript. Usefulness is unclear as I believe it may assume rectangular maps in all situations. TBD.
  Somebody has done a mono implementation of this as well if we want to go that route.
- [Red Blob Games](https://www.redblobgames.com/grids/hexagons/) &mdash; One of the elder write-ups
  on hex maps on the internet. Discusses mechanics of several coordinate systems and has a bunch of
  other pointers.
- [HexGrid](https://github.com/HugoEnzo/HexGrid_Godot_4.0) &mdash; Addon for 4.0 that implements algos
  as specified in the Red Blob writeup.
    - Possibly a reimplementation of [romlok/gdhexgrid](https://github.com/romlok/godot-gdhexgrid)
- [Hex Grid Basics](https://youtu.be/1qmXFIJU1QE) &mdash; Video covering some super basics on interacting
  with the Godot4 hex tile map. tl;dr is that it works "just like" normal tilemaps.
- [Godot docs](https://docs.godotengine.org/en/stable/classes/class_tilemap.html#class-tilemap-method-local-to-map) &mdash; `local_to_map` converts a local Vector2 into a tilemap
  coordinate. The coord is also represented as a `Vector2` but I can't find anything yet indicating what
  system Godot uses, i.e., offset or axial since it encodes to `Vector2`.

## Data management
TBD