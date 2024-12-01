local Fovy = require("fovy.fovy")
local CharacterList = require("characters.characterList")
local Global = require("global")
local Anim8 = require("lib.anim8")

love.graphics.setDefaultFilter("nearest", "nearest")

Player = {
	characterID = 1,
	name = "Unknown",
	spd = 1,
	hsp = 0,
	vsp = 0,
	force = Fovy.vec2(0, 0),
	pos = Fovy.vec2(100, 100),
	collision = Fovy.dim(Global.tileSize, Global.tileSize),

	scale = 1,
	state = "idle",
	xscale = 1,
	yscale = 1,
	spriteStates = {
		idle = Fovy.newSprite("sprites/player/linda_idle.png", 64, 64, "1-2", 1, 0.7),
		move = Fovy.newSprite("sprites/player/linda_move.png", 64, 64, "1-10", 1, 0.11),
	},
}

Object = {
	pos = Fovy.vec2(180, 100),
	collision = Fovy.dim(50, 50),
}

local currentSprite = Player.spriteStates.idle

function Player.set(id)
	local c = CharacterList

	for key in pairs(Player) do
		if c[Player.characterID][key] ~= nil then
			Player[key] = c[Player.characterID][key]
		end
	end

	Player.characterID = id
	Player.get().load()
end

function Player.get()
	return CharacterList[Player.characterID]
end

function Player.getPosition()
	return {
		x = Player.pos.x,
		y = Player.pos.y,
	}
end

function Player.isMoving()
	if Player.hsp ~= 0 or Player.vsp ~= 0 then
		return true
	end
	return false
end

function Player.setForce(x, y)
	Player.force.x = x or 0
	Player.force.y = y or 0
end

function Player.setScale(value)
	Player.scale = value
	Player.collision = Fovy.dim(24 * value, 36 * value)
end

function Player.movement(dt)
	-- Set force to 0
	Player.force.x = Fovy.lerp(Player.force.x, 0, 0.1)
	Player.force.y = Fovy.lerp(Player.force.y, 0, 0.1)

	local dx, dy = 0, 0

	if love.keyboard.isDown("w") then
		dy = dy - Player.spd
	end

	if love.keyboard.isDown("a") then
		dx = dx - Player.spd
	end

	if love.keyboard.isDown("s") then
		dy = dy + Player.spd
	end

	if love.keyboard.isDown("d") then
		dx = dx + Player.spd
	end

	local length = math.sqrt(dx * dx + dy * dy)
	if length > 0 then
		dx = dx / length
		dy = dy / length

		Player.state = "move"
	else
		Player.state = "idle"
	end

	Player.hsp = dx + Player.force.x * Global.gameSpeed
	Player.vsp = dy + Player.force.y * Global.gameSpeed

	Player.pos.x = Player.pos.x + Player.hsp * Player.spd
	Player.pos.y = Player.pos.y + Player.vsp * Player.spd

	-- Sprites
	currentSprite.anim:update(dt)

	if Player.hsp ~= 0 then
		Player.xscale = Fovy.sign(Player.hsp)
	end

	-- Collisions

	Player.get().update(Player)
end

function Player.drawPlayer()
	-- Draw Player States
	local stt = Player.state
	local spr = Player.spriteStates
	local pos = Player.pos

	-- Select sprite accoriding to Player's state
	if stt == "idle" then
		currentSprite = spr.idle
	elseif stt == "move" then
		currentSprite = spr.move
	end

	love.graphics.setColor(1, 1, 1)
	currentSprite.anim:draw(
		currentSprite.image,
		pos.x,
		pos.y,
		0,
		Player.scale * Player.xscale,
		Player.scale * Player.yscale,
		currentSprite.image:getWidth() / (2 * currentSprite.grid.width),
		currentSprite.image:getHeight() / 2
	)

	-- Character's draw function
	Player.get().draw(Player)

	if Global.isDev then
		local width = Player.collision.width
		local height = Player.collision.height
		Fovy.rect(Player.pos.x, Player.pos.y, width, height, Global.devColor, "line")
	end
end

return Player
