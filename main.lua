function love.load()
  backgroundColor = {58, 154, 187}
  warship = love.graphics.newImage('warship.png')
end

function love.draw()
  love.graphics.setBackgroundColor(backgroundColor[1], backgroundColor[2], backgroundColor[3])

  love.graphics.draw(warship, 250, 250)
end
