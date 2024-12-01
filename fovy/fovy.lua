-- My "library" I guess idk how to use lua this is probably available already but i don't know

local Anim8 = require("lib.anim8")

Fovy = {}

function Fovy.dim(width, height)
	return {
		width = width,
		height = height,
	}
end

function Fovy.vec2(x, y)
	return {
		x = x,
		y = y,
	}
end

function Fovy.lerp(a, b, t)
	return a + t * (b - a)
end

function Fovy.hasSameVariable(obj1, obj2)
	for key in pairs(obj1) do
		if obj2[key] ~= nil then
			return true
		end
	end
	return false
end

function Fovy.printTable(t, indent)
	if not indent then
		indent = 0
	end
	for k, v in pairs(t) do
		local prefix = string.rep("  ", indent)
		if type(v) == "table" then
			print(prefix .. k .. ": {")
			Fovy.printTable(v, indent + 1)
			print(prefix .. "}")
		else
			print(prefix .. k .. ": " .. tostring(v))
		end
	end
end

function Fovy.rect(x, y, width, height, color, mode)
	love.graphics.setColor(color)
	love.graphics.rectangle(mode or "fill", x - width / 2, y - height / 2, width, height)
end

function Fovy.newSprite(imageURL, width, height, gridRow, gridColumn, speed)
	local sprite = {}

	sprite.image = love.graphics.newImage(imageURL)
	sprite.grid = Anim8.newGrid(width, height, sprite.image:getWidth(), sprite.image:getHeight())
	sprite.anim = Anim8.newAnimation(sprite.grid(gridRow, gridColumn), speed)

	return sprite
end

function Fovy.sign(x)
	if x > 0 then
		return 1
	elseif x < 0 then
		return -1
	else
		return 0
	end
end

function Fovy.isColliding(obj1, obj2)
	local x1, y1, x2, y2 = obj1.pos.x, obj1.pos.y, obj2.pos.x, obj2.pos.y

	local w = x1 + obj1.collision.width / 2 > x2 - obj2.collision.width / 2
		and x1 - obj1.collision.width / 2 < x2 + obj2.collision.width / 2
	local h = y1 + obj1.collision.height / 2 > y2 - obj2.collision.height / 2
		and y1 - obj1.collision.height / 2 < y2 + obj2.collision.height / 2

	if w and h then
		print("Is Colliding")
	end
end

return Fovy
