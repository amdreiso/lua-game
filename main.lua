-- Main

local Window = require 'window'
local Player = require 'player.main'
local Camera = require 'camera'
local Global = require 'global'
local CharacterList = require 'characters.characterList'


function love.load()
  Window.settings(
    "window",
    1280,
    720,
    false,
    true
  )

  love.graphics.setBackgroundColor(0, 0, 0)
  Player.set(1)
  Camera.setScale(2)
end

function love.update(dt)
  -- Update Player
  Player.movement(dt)

  Camera.setPosition(
    Player.pos.x - love.graphics.getWidth() / 2,
    Player.pos.y - love.graphics.getHeight() / 2,
    0.08
  )
end

function love.draw()
  Camera.attach()

  -- Draw everything relative to the camera perspective
  Player.draw()

  Camera.detach()


  -- Draw dev stuff
  if (Global.isDev) then
    local p = love.graphics.print
    p("x: " .. Player.pos.x .. " y: " .. Player.pos.y, 0, 0)
    p("Character: " .. CharacterList[Player.characterID].name, 0, 12)
  end
end
