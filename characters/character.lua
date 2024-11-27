local Fovy = require 'fovy.fovy'

Character = {}

function Character:new(name, spd)
  local o = {
    name = name,
    spd = spd or 1
  }

  setmetatable(o, self)
  self.__index = self
  return o
end

return Character
