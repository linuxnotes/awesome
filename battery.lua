--
-- BATTERY WIDGET REALIZATION
--

---------------- BATTERY ---------------------------------
-- batwidget = awful.widget.progressbar()
-- batwidget:set_width(10)
-- batwidget:set_height(20)
-- batwidget:set_vertical(true)
-- batwidget:set_background_color("#494B4F")
-- batwidget:set_border_color(nil)
-- batwidget:set_color("#AECF96")
-- batwidget:set_gradient_colors({ "#AECF96", "#88A175", "#FF5656" })
-- vicious.register(batwidget, vicious.widgets.bat, "$2", 61, "BAT1")

-- еще вариант, правда http://awesome.naquadah.org/wiki/Gigamo_Battery_Widget
-- для 3.5

--
require("awful")
local battery = {}
local image_widget = widget({type = "imagebox"})
image_widget.image = image("/usr/share/icons/gnome/16x16/devices/battery.png")

local battery_widget = widget({type="textbox", align = "right"})
local function batteryInfo(adapter)
   spacer = " "
   val = os.capture("cat /sys/class/power_supply/".. adapter .. "/capacity")
   number = tonumber(string.match(val, "%d+"))
   write_log("number:" .. number)
   text  = "" .. val
   if number > 70 then
      text = "<span foreground=\"green\">" .. text .. "</span>"
   elseif number > 10 then
      text = "<span foreground=\"yellow\">" .. text .. "</span>"
   else
      text = "<span foreground=\"red\">" .. text .. "</span>"
   end
   text = text .. "|"
   write_log("text:" .. text)
   battery_widget.text = text
end

batteryInfo("BAT1")
local battery_timer = timer({timeout = 60})
battery_timer:add_signal("timeout", function()
                            batteryInfo("BAT1")
end)
battery_timer:start()

battery.image_widget = image_widget
battery.battery_widget = battery_widget

return battery
------------------------- FINISH BATTERY --------------------------------------
