extends RefCounted

class_name AxialCoords

var q: int
var r: int
var xy: Vector2

func _to_string() -> String:
  return "(q:%d,r:%d)" % [q, r]

static func FromQR(q_in: int, r_in: int) -> AxialCoords:
  var ac := AxialCoords.new()
  ac.q = q_in
  ac.r = r_in
  var a := axial_to_evenr(q_in, r_in)
  ac.xy = Vector2(a[0], a[1])
  return ac

static func FromXY(x: int, y: int) -> AxialCoords:
  var ac := AxialCoords.new()
  var axial := evenr_to_axial(x, y)
  ac.q = axial[0]
  ac.r = axial[1]
  ac.xy = Vector2(x, y)
  return ac

static func FromXYVector(xy: Vector2) -> AxialCoords:
  return FromXY(xy[0], xy[1])

static func axial_to_evenr(q_in: int, r_in: int) -> Array[int]:
    var x: int = q_in + (r_in + (r_in&1)) / 2
    var y: int = r_in
    return [x, y]

static func evenr_to_axial(x: int, y: int) -> Array[int]:
    var q_out: int = x - (y + (y&1)) / 2
    var r_out: int = y
    return [q_out, r_out]