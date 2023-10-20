draw_set_color(c_white)

var str = "seed: " +string(random_get_seed()) + "\n" +
		  "state: " +string(global.random_state) + "\n" +
		  "frame: " + string(frame) + "\n" +
		  //"enemies: " + string(instance_number(enemy)) + "\n" +
		  "checksum: " + string(checksum) + "\n" +
		  "net(" + string(delay) + "): " + string(netframe) + "\n"

// str += last_frame + "\n" + string(floor(netframe / 10) * 10) + "\n"

str += string(inputs[0][$ netframe]) + "\n"
str += string(inputs[1][$ netframe]) + "\n"

// str += "pings:" + string(ping_count)

draw_set_font(fntSmall)
draw_set_halign(fa_left)

draw_text_shadow(72, 24, str)

if desynced {
	draw_set_color(c_red)
	draw_text_shadow(view_width / 2, 24, "DESYNCED!")
	draw_set_color(c_white)
}

scrDrawAlignCenter()

with Player {
	var _x = bbox_center_x - view_xview,
		_y = bbox_bottom - view_yview + 4
	
	draw_text_shadow(_x, _y, string(round(x)) + " " + string(round(y)))
}

scrDrawAlignDefault()

draw_set_font(fntM1)


if !instance_exists(CoopMenu) {
    draw_set_color(c_gray)
    draw_set_font(fntSmall)
    draw_set_halign(fa_left)
	
	var w = 28
	
	draw_sprite_stretched_ext(sprAchievementSplash, 0, 0, 0, w, 8, c_black, 0.8)
	
	scrDrawAlignCenter()
	
    if !global.is_server {
		var host = playerinstance_get(0)
		
		if host != undefined
			draw_text_shadow(w / 2, 4, string(round(host.latency)) + "ms")
    }
	else draw_text_shadow(w / 2, 4, string(array_length(sockets) + 1) + "/4")
	
	scrDrawAlignDefault()

    draw_set_font(fntM1)
    draw_set_color(c_white)
	
    exit
}

var mx = device_mouse_x_to_gui(0),
	my = device_mouse_y_to_gui(0)

draw_set_halign(fa_left)

var dx = view_width / 2,
	dy = view_height / 2 + 72

// "Go" button & run start
if global.is_server {
    gpu_set_fog(1, c_black, 0, 1)
    
	draw_sprite(sprGoButton, 0, dx + 1, dy + 1)
    draw_sprite(sprGoButton, 0, dx, dy + 1)
	
    gpu_set_fog(0, c_black, 0, 1)

    draw_sprite(sprGoButton, 0, dx, dy)
	
    if mouse_check_button_pressed(mb_left) && point_in_rectangle(mx, my, dx - 48, dy - 12, dx + 48, dy + 12) {
        instance_create(0, 0, GameCont)
		
        global.seed = randomize()
        random_set_seed(global.seed)
		global.random_state = global.seed
		
		global.time = 0
		
        for (var i = 0; i <= 12; i++) {
			global.rng_state[i] = global.seed
		}
		
        with SpiralCont {
			instance_destroy()
		}
		
        UberCont.daily_run = 0
        UberCont.weekly_run = 0

        instance_create(0, 0, MenuGen)

        with CoopMenu {
            instance_destroy()
        }
		
		started = true
		
        packet_begin(event.start)
        packet_write(buffer_string, json_stringify(playerindexes))
        packet_write(buffer_u32, global.seed)
        packet_send()
		
		snd_play(sndPortalOld)
		
		network_lock()
		
		//if network_clientcount() > 0
		//	network_lock()
	}
}