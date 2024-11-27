-- Player code
local Fovy = require 'fovy.fovy'
local CharacterList = require 'characters.characterList'
local Global = require 'global'

Player = {
  characterID = 1,
  name = "Unknown",
  spd = 1,
  force = Fovy.vec2(0, 0)
}


Player.pos = Fovy.vec2(100, 100)
Player.collision = Fovy.dim(Global.tileSize, Global.tileSize)


function Player.set(id)
  local c = CharacterList

  for key in pairs(Player) do
    if (c[Player.characterID][key] ~= nil) then
      Player[key] = c[Player.characterID][key]
    end
  end

  Player.characterID = id
end

function Player.movement(dt)
  local dx, dy = 0, 0

  if (love.keyboard.isDown("w")) then
    dy = dy - Player.spd
  end

  if (love.keyboard.isDown("a")) then
    dx = dx - Player.spd
  end

  if (love.keyboard.isDown("s")) then
    dy = dy + Player.spd
  end

  if (love.keyboard.isDown("d")) then
    dx = dx + Player.spd
  end

  local length = math.sqrt(dx * dx + dy * dy)
  if (length > 0) then
    dx = dx / length
    dy = dy / length
  end

  Player.pos.x = Player.pos.x + dx * Player.spd
  Player.pos.y = Player.pos.y + dy * Player.spd
end

-- Draw Player
local currentSprite

function Player.draw()
  local size = 16

  love.graphics.setColor(200, 200, 200)
  love.graphics.rectangle(
    "fill",
    Player.pos.x - size / 2,
    Player.pos.y - size / 2,
    size,
    size
  )
end

return Player
