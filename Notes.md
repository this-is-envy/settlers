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
- [Catlike Coding](https://catlikecoding.com/unity/tutorials/hex-map/) &mdash; Unity centric (and old versions at that) but goes into many aspects of dealing
  with hex maps. Probably some relevant info and CLC is a great resource in general.

### Coordinate systems
Godot's coordinate system situation is currently mostly jank but [TestCoords.gd](./Scratch/TestCoords.gd)
has a demo project that converts clicks into tile coordinates without getting messed up by
node or viewport offsets.

Using Godot's `Stacked` layout the tiles use an `even-r` coordinate system.

## Initial Design Thoughts

### Map Metadata
A lot of words have been spilled on how to deal with hex maps but I haven't seen much that
discusses modeling edge / node data.

To me the most intuitive approach would be something like a metedata store with each tile given an
ID and using that in a keyed lookup, i.e.,
- `Map<(ID, ID, ID), VData>` for tracking vertex data
- `Map<(ID, ID), EData>` for tracking edge data
- `Map<ID, NDate>` for node data

You get the benefit if trivially being able to hydrate information for a given tile/set and can build
overlays by walking map keys.

Using an ID is not necessary but I believe would be easier to talk about than using a Vector2/3
depending on your coordinate system. it would also allow us to vary the coordinate system depending
on use case and not have to worry about remembering if this `Vector2` is our system or Godot's...
assuming that the Godot coordinates are not in the same system we end up using.

Node data could alternatively be stored on the tile but it may be easier to have a per-use case
datastore than piling everything into the Node.

### Structure
I'm fairly certain that Godot eschews traditional design patterns:

> We recommend dismissing architectural code patterns when making games with Godot, such
> as Model-View-Controller (MVC) or Entity-Relationship diagrams. Instead, you can start
> by imagining the elements players will see in your game and structure your code around
> them.
>
>&mdash; [Scene instances as a design language](https://docs.godotengine.org/en/stable/getting_started/step_by_step/instancing.html#scene-instances-as-a-design-language)

But I think there will be merit to retaining a hard separation between board state and its
rendering. Beyond that as a guiding principle I don't have a firm design in mind.