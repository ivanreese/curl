surfaces.vectors.resize = (surface)->
  for vecList in vectors
    for vec in vecList
      deletePhasor vec.aName
      deletePhasor vec.sName

  vectors = []

  size = Math.min width, height
  vectorSpacing = Math.floor size/10

  xVecs = Math.ceil width/vectorSpacing
  yVecs = Math.ceil height/vectorSpacing

  for i in [0..xVecs]
    x = i * vectorSpacing
    vectors[i] = []
    for j in [0..yVecs]
      y = j * vectorSpacing
      aName = "vectors-#{x}-#{y}a"
      sName = "vectors-#{x}-#{y}s"
      makeNoisePhasor aName, 120, 25, 0, i*8, j
      makeNoisePhasor sName, 70, 30, 0, -i*8, -j
      vectors[i].push vec =
        aName: aName
        sName: sName
        x: x
        y: y
        initAngle: simplex2 i/15, j/15
      vec.angle = vec.initAngle + sampleNoisePhasor(vec.aName, 0).v
      vec.strength = 0

  null


surfaces.vectors.simulate = (t, dt)->
  for vecList in vectors
    for vec in vecList
      # vec.angle = vec.initAngle + sampleNoisePhasor(vec.aName, t).v
      # vec.strength = sampleNoisePhasor(vec.sName, t).v * .5 + .5

      dx = mouseX - vec.x
      dy = mouseY - vec.y
      dist = Math.sqrt(dx*dx + dy*dy)
      range = 200
      strength = (1 - dist/range)
      vec.angle = Math.atan2(dy, dx)/TAU
      if strength > 0
        vec.strength = 3 * strength

      # targetAngle = Math.atan2(mouseY-vec.y, mouseX-vec.x)
      # vec.angle += (vec.angle - targetAngle)/30
  null


surfaces.vectors.render = (ctx, t)->
  ctx.lineWidth = 2
  ctx.strokeStyle = "#999"

  for vecList in vectors
    for vec in vecList
      ctx.beginPath()
      x = vec.x
      y = vec.y
      ctx.moveTo x, y
      x = vec.x + vec.strength * vectorSpacing/2 * Math.cos vec.angle * TAU
      y = vec.y + vec.strength * vectorSpacing/2 * Math.sin vec.angle * TAU
      ctx.lineTo x, y
      ctx.stroke()
  true
