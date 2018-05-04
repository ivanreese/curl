surfaces =
  snow:
    doSimulate: true
    doRender: true
    # clear: true

width = 0
height = 0

running = false
renderRequested = false

worldTime = 0
lastTime = null

timeScale = 1

hasMoved = false
mouseX = 0
mouseY = 0
lastMouseX = null
lastMouseY = null
mouseDx = null
mouseDy = null
mouseDist = null

# This tweaks phasor radius/shift values to be more intuitive
phasorComplexityTuning = 1/50

phasors = {}

vectorSpacing = 100
vectors = []

snow = []
maxSnow = 2000
