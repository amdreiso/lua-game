local c = require 'characters.character'

CharacterList = {}

function Add(name, spd)
  table.insert(CharacterList, c:new(
    name,
    spd
  ))
end

Add("Amanda", 2)
Add("Victoria", 4)

return CharacterList
