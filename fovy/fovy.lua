-- My "library" I guess idk how to use lua this is probably available already but i don't know

Fovy = {}

function Fovy.dim(width, height)
  return {
    width = width,
    height = height
  }
end

function Fovy.vec2(x, y)
  return {
    x = x,
    y = y
  }
end

function Fovy.lerp(a, b, t)
  return a + t * (b - a)
end

function Fovy.hasSameVariable(obj1, obj2)
  for key in pairs(obj1) do
    if (obj2[key] ~= nil) then
      return true
    end
  end
  return false
end

return Fovy
