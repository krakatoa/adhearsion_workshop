# encoding: utf-8

require 'call_controllers/main_controller'
require 'call_controllers/account_menu_controller'

Adhearsion.router do

  # Specify your call routes, directing calls with particular attributes to a controller

  route 'default', MainController
end
