local character = {
  
}

function character.draw()
  img = love.graphics.newImage("assets/images/munchlax/munchlax_left_sheet.png")
  quad = love.graphics.newQuad(0, 0, 32, 160, img:getDimensions() )
  love.graphics.draw(img,quad, 0, 32)
end

return character