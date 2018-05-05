freshSnake = (snake)->
  snake.x = snake.ox
  snake.y = snake.oy
  snake.hist = []
  return snake


spawnSnake = (x, y)->
  snakes.push freshSnake {ox:x, oy:y}


surfaces.particles.resize = ()->
  return if snakes.length > 0
  for x in [0..width] by snakeSpacing
    for y in [0..height] by snakeSpacing
      spawnSnake x, y
  null


surfaces.particles.simulate = (t)->
  velAmt = (0.01 + Math.pow(mouseX/width, 3)) * 100
  curlAmt = (0.01 + Math.pow(mouseY/height, 3)) * 100


  if t > spawnTime
    spawnTime += spawnInterval
    total = Math.ceil(width/snakeSpacing) * Math.ceil(height/snakeSpacing)
    newSnakes = total - snakes.length
    newSpacing = Math.floor snakeSpacing * total/newSnakes
    for x in [0..width] by newSpacing
      for y in [0..height] by newSpacing
        spawnSnake x, y





surfaces.particles.render = (ctx, t, dt)->
  return unless snakes.length > 0

  ctx.lineWidth = 1
  ctx.strokeStyle = "hsl(0, 0%, 100%)"

  for snake, i in snakes by -1
    scaledX = snake.x/vectorSpacing
    scaledY = snake.y/vectorSpacing

    if lower = vectors[Math.floor scaledX]
      vecA = lower[Math.floor scaledY]
      vecB = lower[Math.ceil scaledY]
    if upper = vectors[Math.ceil scaledX]
      vecC = upper[Math.floor scaledY]
      vecD = upper[Math.ceil scaledY]

    if vecA? and vecB? and vecC? and vecD?
      vecSnowDist dt, snake, vecA
      vecSnowDist dt, snake, vecB
      vecSnowDist dt, snake, vecC
      vecSnowDist dt, snake, vecD

    ctx.beginPath()
    ctx.moveTo snake.x, snake.y

    for h in snake.hist
      ctx.lineTo h.x, h.y

    snake.hist.unshift {x:snake.x, y:snake.y}
    if snake.hist.length > 7
      snake.hist.pop()

    if snake.x < 0 or snake.y < 0 or snake.x > width or snake.y > height
      tail = snake.hist[snake.hist.length-1]
      if tail.x < 0 or tail.y < 0 or tail.x > width or tail.y > height
        snakes.splice i, 1

    ctx.stroke()
  true


simplexScale = 0.003
scaledSimplex2 = (x, y)->
  200 * simplex2 simplexScale * x, simplexScale * y


vecSnowDist = (dt, snake, vec)->
  dx = vec.x - snake.x
  dy = vec.y - snake.y
  dist = Math.sqrt dx*dx+dy*dy
  strength = vec.strength * (1 - dist/vectorSpacing)
  if strength > 0
    snake.x += strength * velAmt * dt * Math.cos vec.angle * TAU
    snake.y += strength * velAmt * dt * Math.sin vec.angle * TAU

    n = scaledSimplex2 snake.x, snake.y

    eps = 1

    n1 = scaledSimplex2 snake.x, snake.y + eps
    n2 = scaledSimplex2 snake.x, snake.y - eps
    a = (n1 - n2) / 2 * eps

    n1 = scaledSimplex2 snake.x + eps, snake.y
    n2 = scaledSimplex2 snake.x - eps, snake.y
    b = (n1 - n2) / 2 * eps

    snake.x += (+a * curlAmt * strength) * dt
    snake.y += (-b * curlAmt * strength) * dt
