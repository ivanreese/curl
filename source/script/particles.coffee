spawnSnake = (x, y)->
  snakes.push
    vx: simplex2 x, y
    vy: simplex2 y, x
    x: x
    y: y
    hist: []
    histSkip: 0


surfaces.particles.resize = ()->
  return if snakes.length > 0
  for x in [0..width] by snakeSpacing
    for y in [0..height] by snakeSpacing
      spawnSnake x, y
  null


surfaces.particles.render = (ctx, t, dt)->
  return unless snakes.length > 0

  ctx.beginPath()
  ctx.lineWidth = 2
  ctx.strokeStyle = "hsl(0, 0%, 100%)"

  for snake, s in snakes by -1
    if snake.x < 0 or snake.y < 0 or snake.x > width or snake.y > height
      snakes.splice s, 1
      continue

    n = scaledSimplex2 snake.x, snake.y

    eps = 1

    n1 = scaledSimplex2 snake.x, snake.y + eps
    n2 = scaledSimplex2 snake.x, snake.y - eps
    a = (n1 - n2) / 2 * eps

    n1 = scaledSimplex2 snake.x + eps, snake.y
    n2 = scaledSimplex2 snake.x - eps, snake.y
    b = (n1 - n2) / 2 * eps

    snake.x += (snake.vx + a * curlAmt) * dt
    snake.y += (snake.vy - b * curlAmt) * dt

    ctx.moveTo snake.x, snake.y

    for h in snake.hist
      ctx.lineTo h.x, h.y

    if snake.histSkip++ % 2 is 0
      snake.hist.unshift {x:snake.x, y:snake.y}
      if snake.hist.length > 20
        snake.hist.pop()

  ctx.stroke()
  true


simplexScale = 0.003
scaledSimplex2 = (x, y)->
  200 * simplex2 simplexScale * x, simplexScale * y
