width = display_get_gui_width()
height = display_get_gui_height()

if instance_number(object_index) > 1 {
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

open = 0

self[$ "text"] = function(x, y, txt, col = draw_get_color(), alpha = draw_get_alpha()) {
    draw_set_color(c_black)
    draw_set_alpha(1)

    draw_text(x - 1, y, txt)
    draw_text(x, y + 1, txt)
    draw_text(x, y - 1, txt)
    draw_text(x + 1, y, txt)

    draw_set_color(col)
    draw_set_alpha(alpha)

    draw_text(x, y, txt)
}