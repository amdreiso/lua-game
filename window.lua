Window = {}

function Window.settings(title, width, height, full, vs)
  love.window.setTitle(title)
  love.window.setMode(width, height, { fullscreen = full, vsync = vs })
end

return Window
