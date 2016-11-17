flux = require 'flux'

function love.load()
  backgroundColor = {58, 154, 187}
  warship = love.graphics.newImage('warship.png')
  warshipLocation = {
    x = 250,
    y = 250,
    moving = false,
    radians = 0
  }
end

function love.update(dt)
  local f = flux.update(dt)
end

function love.draw()
  love.graphics.setBackgroundColor(backgroundColor[1], backgroundColor[2], backgroundColor[3])
  love.graphics.draw(warship, warshipLocation.x, warshipLocation.y, warshipLocation.radians, 1, 1, 16, 16)
end

function love.mousepressed(x, y, button, isTouch)
  local function warshipMoveFinished()
    warshipLocation.moving = false
  end

  local function calculateRadians(x, y)
    return math.atan2(warshipLocation.y - y, warshipLocation.x - x) - (math.pi / 2)
  end

  if not warshipLocation.moving then
    flux.to(warshipLocation, 2, {radians = calculateRadians(x, y)}):after(warshipLocation, 5, {x = x, y = y}):oncomplete(warshipMoveFinished)

    warshipLocation.moving = true
  end
end
