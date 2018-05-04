surfaces =
  vectors:
    doSimulate: false
    doRender: false
  particles:
    doSimulate: true
    doRender: true
    clear: true
  simplex:
    doSimulate: false
    doRender: false

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

snakes = []

# spawnTime = 0
# spawnInterval = 10

snakes = []
snakeSpacing = 20
snakeParticleSpacing = 0.1

velAmt = 20
curlAmt = 20
