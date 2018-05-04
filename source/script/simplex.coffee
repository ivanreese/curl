# surfaces.simplex.resize = (surface)->
#
#   ctx = surface.context
#
#   ctx.clearRect 0, 0, width, height
#
#   step = 3
#   scale = 0.003
#   for x in [0..width] by step
#     for y in [0..height] by step
#       l = Math.floor 30 + 30 * simplex2 x*scale, y*scale
#       ctx.fillStyle = "rgb(#{l},#{l},#{l})"
#       ctx.fillRect x, y, step, step
