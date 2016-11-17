flux = require 'flux'

function love.load()
  backgroundColor = {58, 154, 187}
  warship = love.graphics.newImage('warship.png')
  warshipLocation = {
    x = 250,
    y = 250,
    targetX = 250,
    targetY = 250,
    moving = false,
    speed = 50
  }
end

function love.update(dt)
  local f = flux.update(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(backgroundColor[1], backgroundColor[2], backgroundColor[3])
  love.graphics.draw(warship, warshipLocation.x - 16, warshipLocation.y - 16)
end

function love.mousepressed(x, y, button, isTouch)
  local function warshipMoveFinished()
    warshipLocation.moving = false
  end

  if not warshipLocation.moving then
    flux.to(warshipLocation, 5, {x = x, y = y}):oncomplete(warshipMoveFinished)

    warshipLocation.moving = true
  end
end
