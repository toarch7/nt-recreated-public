/// @description Load custom position

custom_position = false

if save_get_value("controls", key + "_x") != undefined
or save_get_value("controls", key + "_x") != undefined {
	custom_position = true
}

x = save_get_value("controls", key + "_x", x)
y = save_get_value("controls", key + "_y", y)
