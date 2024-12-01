local c = require("characters.character")
local Fovy = require("fovy.fovy")

CharacterList = {}

function Add(characterTable)
	local defaultCharacterTable = {
		name = "Unknown",
		spd = 0.2,
		collision = Fovy.dim(1, 1),
		load = function(obj) end,
		update = function(obj) end,
		draw = function(obj) end,
	}

	for key, val in pairs(characterTable) do
		if defaultCharacterTable[key] ~= nil then
			defaultCharacterTable[key] = val
			print("Character variable " .. tostring(key) .. " set to: " .. tostring(val))
		end
	end

	table.insert(CharacterList, c:new(defaultCharacterTable))
end

Add({
	name = "Linda Storm",
	spd = 3,

	load = function(obj) end,

	spriteStates = {
		idle = Fovy.newSprite("sprites/player/linda_idle.png", 64, 64, "1-2", 1, 0.7),
		move = Fovy.newSprite("sprites/player/linda_move.png", 64, 64, "1-10", 1, 0.11),
	},

	update = function(obj) end,

	draw = function(obj)
		local pos = obj.getPosition()
		local x, y = pos.x, pos.y
	end,
})

return CharacterList
