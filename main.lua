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

  buttonSpeedUp = {
    x = 5,
    y = 25,
    color = {249, 203, 79},
    width = 20,
    height = 20
  }

  buttonSpeedDown = {
    x = 30,
    y = 25,
    color = {29, 141, 250},
    width = 20,
    height = 20
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

  love.graphics.print('speed ' .. warshipLocation.travelRadius, 5, 5)

  love.graphics.setColor(unpack(buttonSpeedUp.color))
  love.graphics.rectangle('fill', buttonSpeedUp.x, buttonSpeedUp.y, buttonSpeedUp.width, buttonSpeedUp.height)

  love.graphics.setColor(unpack(buttonSpeedDown.color))
  love.graphics.rectangle('fill', buttonSpeedDown.x, buttonSpeedDown.y, buttonSpeedDown.width, buttonSpeedDown.height)
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

function isSpeedUpButtonPressed(x, y)
  return buttonSpeedUp.x < x and
  buttonSpeedUp.x + buttonSpeedUp.width > x and
  buttonSpeedUp.y < y and
  buttonSpeedUp.y + buttonSpeedUp.height > y
end

function isSpeedDownButtonPressed(x, y)
  return buttonSpeedDown.x < x and
  buttonSpeedDown.x + buttonSpeedDown.width > x and
  buttonSpeedDown.y < y and
  buttonSpeedDown.y + buttonSpeedDown.height > y
end

function love.mousepressed(x, y, button, isTouch)
  if isSpeedUpButtonPressed(x, y) then
    warshipLocation.travelRadius = warshipLocation.travelRadius + 10
  elseif isSpeedDownButtonPressed(x, y) then
    warshipLocation.travelRadius = warshipLocation.travelRadius - 10
  elseif not warshipLocation.moving and isClickedWithinCircle(x, y) then
    flux.to(warshipLocation, 0.5, {radians = calculateRadians(x, y)}):after(warshipLocation, 2, {x = x, y = y}):oncomplete(warshipMoveFinished)

    warshipLocation.moving = true
  end
end
