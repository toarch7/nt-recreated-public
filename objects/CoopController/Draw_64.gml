draw_set_color(c_white)

//draw_text_shadow(96, 24, string(debugstr))

if !instance_exists(CoopMenu) {
    draw_set_color(c_gray)
    draw_set_font(fontSmall)
    draw_set_halign(fa_left)

    if !global.is_server {
        draw_text_shadow(4, 2, string(round((get_timer() - localdelay) / 1000)))
    } else draw_text_shadow(4, 2, string(array_length(struct_keys(connectedports)) + 1) + "/4")

    draw_set_font(UberCont.font)
    draw_set_color(c_white)

    exit
}

if !instance_exists(Menu) && instance_exists(CoopMenu) && global.is_server && socket >= 0 {
    CoopMenu.text = "PLAYERS JOINED: " + string(array_length(playerindexes) + 1) + "/4"
}

var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)

/*draw_set_halign(fa_center)
//var cfgs = struct_keys(global.coopoptions)
var updated = 0
draw_set_color(global.is_server ? c_white : c_gray)
draw_text_shadow(view_width / 2, view_height / 2 - 2, "OPTIONS:\n(PLACEHOLDER)")

for(var i = 0; i < array_length(cfgs); i ++) {
	var cfg = cfgs[i]
	var px = view_width / 2
	var py = view_height / 2 - 16 + i * 14
	var str = string_upper(cfg) + ": " + (global.coopoptions[$ cfg] ? "ON": "OFF")
	
	draw_text_shadow(px, py, str)
	
	var w = string_width(str) / 2, h = string_height(str) / 2
	
	if device_mouse_check_button_pressed(0, mb_left) && point_in_rectangle(mx, my, px - w, py - h, px + w, py + h) {
		global.coopoptions[$ cfg] = !global.coopoptions[$ cfg]
		updated = 1
		
		snd_play(sndClick)
	}
}
draw_set_color(c_white)
draw_set_halign(fa_left)

if updated {
	buffer_seek(global.buffer, buffer_seek_start, 0)
	buffer_write(global.buffer, buffer_u8, event.set_config)
	buffer_write(global.buffer, buffer_string, json_stringify(global.coopoptions))
	buffer_send(global.buffer)
}*/

draw_set_halign(fa_left)

var dx = view_width / 2
var dy = view_height / 2 + 72

if global.is_server {
    gpu_set_fog(1, c_black, 0, 1)
    draw_sprite(sprGoButton, 0, dx + 1, dy + 1)
    draw_sprite(sprGoButton, 0, dx, dy + 1)
    gpu_set_fog(0, c_black, 0, 1)

    draw_sprite(sprGoButton, 0, dx, dy)

    if mouse_check_button_pressed(mb_left) && point_in_rectangle(mx, my, dx - 48, dy - 12, dx + 48, dy + 12) {
        instance_create(0, 0, GameCont)

        UberCont.playerinstances[$ "0"] = new PlayerInstance(0, 0, 0)

        for (var i = 0; i < array_length(playerindexes); i++) {
            var _ind = playerindexes[i]

            UberCont.playerinstances[$ string(_ind)] = new PlayerInstance(_ind, 0, 0)
        }

        global.seed = randomize()
        random_set_seed(global.seed)

        for (var i = 0; i <= 12; i++)
        global.rng_state[i] = global.seed

        with SpiralCont instance_destroy()

        UberCont.daily_run = 0
        UberCont.weekly_run = 0

        instance_create(0, 0, MenuGen)

        with CoopMenu {
            instance_destroy()
        }

        buffer_seek(global.buffer, buffer_seek_start, 0)
        buffer_write(global.buffer, buffer_u8, event.start)
        buffer_write(global.buffer, buffer_string, json_stringify(playerindexes))
        buffer_write(global.buffer, buffer_u32, global.seed)
        buffer_send(global.buffer)
    }
}