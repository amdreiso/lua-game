local Fovy = require("fovy.fovy")

Character = {}

function Character:new(characterTable)
	local o = characterTable

	setmetatable(o, self)
	self.__index = self
	return o
end

return Character
