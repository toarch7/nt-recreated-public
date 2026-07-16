width = display_get_gui_width()
height = display_get_gui_height()

if (instance_number(object_index) > 1) {
    instance_destroy()
}

history = []
historypos = 0

flags = 0

cursor = "|"
alarm[0] = room_speed
laststr = ""
command_binding = 0
bound_command = ""
alert = ""

seed = undefined

open = false

__draw_text = function(_x, _y, _string, _color = undefined, _alpha = undefined, _scale = 1) {
	draw_set_color(c_black)
	draw_set_alpha(1)
	
	draw_text_transformed(_x - _scale, _y, _string, _scale, _scale, 0)
	draw_text_transformed(_x, _y + _scale, _string, _scale, _scale, 0)
	draw_text_transformed(_x, _y - _scale, _string, _scale, _scale, 0)
	draw_text_transformed(_x + _scale, _y, _string, _scale, _scale, 0)
	
	if (is_numeric(_color)) draw_set_color(_color)
	if (is_numeric(_color)) draw_set_alpha(_alpha)
	
	draw_text_transformed(_x, _y, _string, _scale, _scale, 0)
}

enemy_test = false
enemy_count = 0
enemy_number = 0
enemy_species = {}