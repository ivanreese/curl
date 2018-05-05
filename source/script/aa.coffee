surfaces =
  vectors:
    doSimulate: true
    doRender: false
    clear: true
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
mouseX = -1000
mouseY = -1000
lastMouseX = null
lastMouseY = null
mouseDx = null
mouseDy = null
mouseDist = null

# This tweaks phasor radius/shift values to be more intuitive
phasorComplexityTuning = 1/50

phasors = {}

vectorSpacing = 5
vectors = []

snakes = []

spawnTime = 0
spawnInterval = 1

snakes = []
snakeSpacing = 20
snakeParticleSpacing = 0.1

velAmt = 0
curlAmt = 0
