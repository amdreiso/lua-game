-- Main

local Window = require("window")
local Player = require("player.main")
local Camera = require("camera")
local Global = require("global")
local Game = require("game")

function love.load()
	Window.settings(Game.name, 1280, 720, false, true)

	love.graphics.setBackgroundColor(0, 0, 0)
	Player.set(1)
	Camera.setScale(1)
end

function love.update(dt)
	-- Update Player
	Player.movement(dt)
	Player.setScale(3)

	-- Update Camera
	Camera.setPosition(Player.pos.x - love.graphics.getWidth() / 2, Player.pos.y - love.graphics.getHeight() / 2, 0.08)
end

function love.draw()
	Camera.attach()

	love.graphics.draw(love.graphics.newImage("sprites/player/defaultTile.png"), 0, 0)

	-- Draw everything relative to the camera's perspective
	Player.drawPlayer()

	Camera.detach()

	-- Draw dev stuff
	if Global.isDev then
		local p = love.graphics.print
		p("x: " .. Player.pos.x .. " y: " .. Player.pos.y, 0, 0)
		p("Character: " .. Player.get().name, 0, 12)
	end
end

function love.keypressed(key)
	if key == "f3" then
		Global.isDev = not Global.isDev
	end
end
