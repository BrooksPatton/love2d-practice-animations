flux = require 'flux'

function love.load()
  backgroundColor = {58, 154, 187}
  warship = love.graphics.newImage('warship.png')
  warshipLocation = {
    x = 250,
    y = 250,
    moving = false,
    radians = 0,
    travelRadius = 100
  }
end

function love.update(dt)
  local f = flux.update(dt)
end

function love.draw()
  if not warshipLocation.moving then
    love.graphics.setColor(224, 104, 90)
    love.graphics.circle('line', warshipLocation.x, warshipLocation.y, warshipLocation.travelRadius)
  end

  love.graphics.setColor(255, 255, 255)
  love.graphics.setBackgroundColor(backgroundColor[1], backgroundColor[2], backgroundColor[3])
  love.graphics.draw(warship, warshipLocation.x, warshipLocation.y, warshipLocation.radians, 1, 1, 16, 16)

end

function warshipMoveFinished()
  warshipLocation.moving = false
end

function calculateRadians(x, y)
  return math.atan2(warshipLocation.y - y, warshipLocation.x - x) - (math.pi / 2)
end

function isClickedWithinCircle(x, y)
  local lineA = math.abs(warshipLocation.x - x)
  local lineB = math.abs(warshipLocation.y - y)
  local distanceFromShip = math.sqrt((lineA * lineA) + (lineB * lineB))

  return warshipLocation.travelRadius - distanceFromShip > 0
end

function love.mousepressed(x, y, button, isTouch)
  if not warshipLocation.moving and isClickedWithinCircle(x, y) then
    flux.to(warshipLocation, 0.5, {radians = calculateRadians(x, y)}):after(warshipLocation, 2, {x = x, y = y}):oncomplete(warshipMoveFinished)

    warshipLocation.moving = true
  end
end
