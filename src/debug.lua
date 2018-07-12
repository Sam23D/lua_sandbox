local moses = require "deps.moses"

local debug = {}
local config = {
  config_window_bgcolor = {r = 0.25, g = 0.45, b= 0.62, a=0.1},
  default_debug_level = "log"
}

debug.level_types = {
    log = {r = 0.87, g = 0.9, b = 0.91},
    debug = {r = 0.45, g = 0.73, b = 1},
    error = {r = 1, g = 0.46, b = 0.46}
}
--[[ messages inside de stack MUST be:
    { level, timestamp, msg }
    { "debug", 1531456347, "Hello world!" }
 ]]
local message_stack = {}

debug.draw_system = function( state )
    if (state.visible )then
        debug.print_settings( {} , 10, 10 ) 
        debug.print_debug_stack()
    end
end

debug.toggle_debug_draw = function(state)
    state.visible = not state.visible
end

debug.print_settings = function( settings, x, y )
    local w, h, _ = love.window.getMode()
    local canvas = love.graphics.newCanvas( w, h / 2 )
    love.graphics.setCanvas( canvas )
    local bg_conf = config.config_window_bgcolor
    love.graphics.clear( bg_conf.r, bg_conf.g, bg_conf.b, bg_conf.a )
    -- DO INSIDE THE NEW CANVAS
        padding = 10
        for k, v in pairs( settings ) do
            simple_print( label_value(k, v) , x+10, y + padding )
            padding = padding + 20
        end

    love.graphics.setCanvas()
    love.graphics.draw(canvas, 0, 0)
end

debug.print_debug_stack = function()
    local w, h, _ = love.window.getMode()
    padding = 0
    for _, v in pairs( message_stack ) do
        simple_debug_print( moses.nth(v, 1) ,  format_debug_msg(v) , w/2 , 10 + padding )
        padding = padding + 20
    end
end

debug.log = function( msg, level )
    esc_level = level or config.default_debug_level
    if #message_stack > 10 then moses.pop(message_stack) end
    moses.push( message_stack , { esc_level, os.time(os.date("!*t")), msg} )
end

--[[The structure of a normal debug message is as follows:
    { level, timestamp, message }
    { "log", 1531456347, "Hello world!" }
]]
function format_debug_msg( dbg_msg )
    return ( os.date('%H:%M:%S', moses.nth( dbg_msg, 2 )) .. " - " .. moses.nth( dbg_msg, 3 ) )
end

function simple_debug_print( level, text, x, y )
    escaped = text or "nil"
    if not (debug.level_types[ level] == nil) then 
        lvl_color = debug.level_types[level]
    else
        lvl_color = debug.level_types[config.default_debug_level]
    end
    pr, pg, pb = love.graphics.getColor()
    love.graphics.setColor( lvl_color.r, lvl_color.g, lvl_color.b )
    love.graphics.print( escaped, x, y )
    love.graphics.setColor( pr, pg, pb)
end

function label_value( label, value )
    esc_lbl = label or "nil"
    esc_val = value or "nil"
    return ( "[ ".. esc_lbl .. " ] - " .. esc_val)
end

return debug