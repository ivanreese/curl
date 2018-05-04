absolutePos = (elm)->
  elm.style.position = "absolute"
  elm.style.top = elm.style.left = "0"
  elm.style.width = elm.style.height = "100%"


setupSurface = (surface)->
  surface.canvas = document.createElement "canvas"
  document.body.appendChild surface.canvas
  absolutePos surface.canvas
  surface.context = surface.canvas.getContext "2d"
  surface.setup? surface


resize = ()->
  width = window.innerWidth
  height = window.innerHeight
  for name, surface of surfaces
    surface.canvas.width = width
    surface.canvas.height = height
    surface.resize?(surface)
  null


requestResize = ()->
  widthChanged = 2 < Math.abs width - window.innerWidth
  heightChanged = 50 < Math.abs height - window.innerHeight
  if widthChanged or heightChanged
    requestAnimationFrame (time)->
      first = true
      resize()
      render() unless renderRequested
