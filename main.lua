local model 
 
local ui = require "src.ui"

function love.load()
   love.graphics.setNewFont(14)
   love.graphics.setBackgroundColor(0.208, 0.231, 0.282)
   model = {
        timestamp = 0,
        settings = {
            visible = true
        },
        controlls = {
            mouse = {
                x = 0,
                y = 0,
                [1] = false,
                [2] = false
            },
            up = false,
            down = false,
            left = false,
            right = false,
            space = false
        },
        objects = {
            [1] = {
                pos = {
                    x = 0,
                    y = 0
                }
            }
        }

   }
end
 
function love.update(dt)
    model.timestamp = model.timestamp + dt
end
 
function print_settings( settings, x, y )
    local canvas = love.graphics.newCanvas(300, 400)
    love.graphics.setCanvas( canvas )
    love.graphics.clear(0.25, 0.45, 0.62, .3);
        y_padding = 10
        for k, v in pairs( settings ) do
            love.graphics.print(k .. ": " .. v, x +  10, y + y_padding )
            y_padding = y_padding + 20
        end
    love.graphics.setCanvas()
    love.graphics.draw(canvas, x, y)

end

function love.keypressed( key )
    model.controlls[key] = true
    model.text = key .. " has been pressed!"
    if key == "o" then model.settings.visible = not model.settings.visible end
   
end

function love.keyreleased( key )
    model.controlls[key] = false
    model.text = key .. " has been released!"

end

function love.mousepressed( x, y, button, isTouch )
    model.controlls.mouse[button] = true
end
 
function love.mousereleased( x, y, button, isTouch )
    model.controlls.mouse[button] = false
end

function love.mousemoved( x, y, dx, dy, istouch )
    model.controlls.mouse.x = x
    model.controlls.mouse.y = y
    update_rect_pos(x,y)
end
function love.draw()
    some = { samuel = "blanco",
    edad = 24,
    peso = 84
    }
    if model.settings.visible then print_settings( some, 10, 10 ) end
end

function update_rect_pos( x, y )
    model.objects[1].pos.x = x
    model.objects[1].pos.y = y
end