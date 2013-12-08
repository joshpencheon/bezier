class Point
  @zip: (p1, p2, func = (x,y) -> [x, y]) ->
    new this (for i in [0...Math.max(p1.size(), p2.size())]
      func(p1.components[i] || 0, p2.components[i] || 0))...
  constructor: (@components...) ->

  times: (scalar) -> new Point (p * scalar for p in @components)...
  plus: (point) -> Point.zip(@, point, (x,y) -> x + y)
  size: -> @components.length
  coords: -> @components.join(',')
  subtract: (point) -> @plus point.times(-1)

class BezierCurve
  constructor: (@points...) ->

  evaluate: (t, points = @points) ->
    scales = for e1, i in points when (e2 = points[i+1])?
      e1.plus e2.subtract(e1).times(t)
    if scales.length == 1 then scales[0] else @evaluate t, scales

class BezierPath
  constructor: (@curve) ->

  control: -> @generate @curve.points
  sample: (times = 20) ->
    @generate (@curve.evaluate (+t.toFixed 5) for t in [0..1] by 1.0 / times)
  generate: (points) ->
    "M#{points.shift().coords()} #{("L#{p.coords()}" for p in points).join(' ')}"
