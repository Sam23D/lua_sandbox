local ui = require "src.ui"
local world = require "src.world.config"
local state = require "src.state"
local debug = require "src.debug"
local ctrl_sys = require "src.controls.system"

function love.load()
   pixellari = love.graphics.setNewFont("assets/Roboto-Regular.ttf", 16)
   love.graphics.setBackgroundColor(0.208, 0.231, 0.282)
   
end
 
function love.update(dt)
    state.timestamp = state.timestamp + dt
end

function love.keypressed( key )
    
    ctrl_sys.handle_key_press( key )
end

function love.keyreleased( key )
    
end

function love.mousepressed( x, y, button, isTouch )
end
 
function love.mousereleased( x, y, button, isTouch )
end

function love.mousemoved( x, y, dx, dy, istouch )
    
end

function love.draw()
    debug.draw_system( state.settings.debug_state )
end
