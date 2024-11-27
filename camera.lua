local Fovy = require 'fovy.fovy'

Camera = {}

-- Variables
Camera.pos = Fovy.vec2(0, 0)
Camera.scale = 1
Camera.spd = 1


-- Functions
function Camera.setPosition(targetX, targetY, value)
  Camera.pos.x = Camera.pos.x + (targetX - Camera.pos.x) * (value)
  Camera.pos.y = Camera.pos.y + (targetY - Camera.pos.y) * (value)
end

function Camera.setScale(val)
  print("Camera scaled to ", val)
  Camera.scale = val
end

function Camera.attach()
  local xx, yy = Camera.pos.x, Camera.pos.y

  love.graphics.push()
  love.graphics.translate(-xx, -yy)
  love.graphics.scale(Camera.scale, Camera.scale)
end

function Camera.detach()
  love.graphics.pop()
end

function Camera.draw()
end

return Camera
