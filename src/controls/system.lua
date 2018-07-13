

local control_system = {}
local state = require "src.state"
local debug = require "src.debug"

control_system.controls = {
  up = "w",
  down = "s",
  left = "a",
  right = "d",
  a1 = "j",
  a2 = "k"
}

control_system.callback_table = {

}

control_system.handle_key_press = function ( key )
  if key == "p" then 
    debug.toggle_debug_draw(state.settings.debug_state) 
    debug.log(key)
  end
  
end

return control_system