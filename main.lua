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
  if warshipLocation.moving then
    local xDiff = warshipLocation.x - warshipLocation.targetX
    local yDiff = warshipLocation.y - warshipLocation.targetY

    if math.abs(xDiff) < 1 and math.abs(yDiff) < 1 then
      warshipLocation.x = warshipLocation.targetX
      warshipLocation.y = warshipLocation.targetY
      warshipLocation.moving = false
    else
      if xDiff < 0 then
        warshipLocation.x = warshipLocation.x + warshipLocation.speed * dt
      else
        warshipLocation.x = warshipLocation.x - warshipLocation.speed * dt
      end

      if yDiff < 0 then
        warshipLocation.y = warshipLocation.y + warshipLocation.speed * dt
      else
        warshipLocation.y = warshipLocation.y - warshipLocation.speed * dt
      end
    end
  end
end

function love.draw()
  love.graphics.setBackgroundColor(backgroundColor[1], backgroundColor[2], backgroundColor[3])
  love.graphics.draw(warship, warshipLocation.x - 16, warshipLocation.y - 16)
end

function love.mousepressed(x, y, button, isTouch)
  if not warshipLocation.moving then
    warshipLocation.targetX = x
    warshipLocation.targetY = y
    warshipLocation.moving = true
  end
end
