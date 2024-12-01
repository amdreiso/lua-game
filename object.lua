local Fovy = require("fovy.fovy")

Object = {}

function Object:new(x, y, width, height)
	local o = {}
	o.pos = Fovy.vec2(x, y)
	o.collision = Fovy.dim(width, height)

	setmetatable(o)
	self.__init = self
	return o
end

return Object
