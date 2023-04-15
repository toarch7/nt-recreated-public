if UberCont.showtutorial {
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    draw_text_shadow(view_width / 2, view_height / 2, "YOU HAVEN'T COMPLETED TUTORIAL LEVEL YET")
    draw_set_halign(fa_top)
    draw_set_valign(fa_left)
    exit
}

var mx = device_mouse_x_to_gui(0)
var my = device_mouse_y_to_gui(0)
var dx = view_width / 2
var dy = view_height / 2

if !instance_exists(CoopController) {
    if keyboard_check_pressed(vk_space) {
        host_game()
    }

    if keyboard_check_pressed(vk_enter) {
        join_remote(global.ip)
    }
}

if gamepad_button_check_pressed(0, gp_start) {
    with UberCont
    localcoop = 1

    var ind = 0

    repeat 2 {
        var inst = new PlayerInstance(ind, irandom(10) + 1, !irandom(2))
        UberCont.playerinstances[$ string(ind)] = inst
        inst.cwep = UberCont.race_swep[inst.race]
        ind++
    }

    with SpiralCont instance_destroy()

    instance_create(0, 0, GameCont)
    instance_create(0, 0, MenuGen)

    with CoopMenu {
        instance_destroy()
    }
}

draw_set_color(c_white)
draw_set_halign(fa_center)
draw_set_valign(fa_center)

var _str = string_upper(string(text))
/*
with CoopController {
	if loading_text != "" {
		_str += "\n\n" + string(loading_text)
	}
}*/

draw_text_shadow(view_width / 2, view_height / 2 /* - 56*/ , _str)
draw_set_halign(fa_left)

if !instance_exists(CoopController) {
    draw_set_halign(fa_right)
	
	draw_bigname(dx, dy, "HOST", c_white)
	
	draw_set_halign(fa_center)

    if mouse_check_button_pressed(mb_left) && active {
        if point_in_rectangle(mx, my, dx - 48, dy - 12, dx + 48, dy + 12) {
            global.is_server = 1
            network_destroy(server)
            server = -1

            instance_create(0, 0, CoopController)
            text = "WAIT FOR OTHER PLAYERS..."

            snd_play(sndMenuClick)
        }
    }

    dx = view_width - 4
    dy = 48

    var h = string_height("A")
    var _names = variable_struct_get_names(local_games)

    draw_text_nt(dx, 48, (array_length(_names) > 0 ? "@w" : "@s") + loc("LOCAL GAMES"))

    if array_length(_names) {
        for (var i = 0; i < array_length(_names); i++) {
            var _key = _names[i]
            var _val = local_games[$ _key]

            dy += h

            var col = "@s"

            if point_in_rectangle(mx, my, dx - 120, dy - h / 2, dx + 4, dy + h / 2) {
                col = "@w"

                if lastpoint != _key {
                    snd_play(sndMenuSelect)
                    lastpoint = _key
                }

                if mouse_check_button_released(mb_left) {
                    snd_play(sndMenuClick)
                    global.is_server = 0

                    global.ip = _val.ip
                    network_destroy(server)
                    server = -1

                    global.port = _val.port
                    instance_create(0, 0, CoopController)
                    text = "CONNECTING TO " + _val[$ "name"] + "..."
                }
            }

            draw_text_nt(dx, dy, col + string(_val[$ "name"]) + "'s game")
        }
    }

    /*_key = "REFRESH"
	
	dy += h * 2
	
	draw_text_nt(dx + 7, dy, (!refresh? (lastpoint == "REFRESH" ? "@g" : "@w"): "@d") + loc(_key))
	
	if point_in_rectangle(mx, my, dx - 120, dy - h / 2, dx + 4, dy + h / 2) {
		if lastpoint != _key {
			snd_play(sndMenuSelect)
			lastpoint = _key
		}
		
		if mouse_check_button_released(mb_left) {
			local_games = {}
			
			refresh = 30
			snd_play(sndMenuClick)
		}
	}*/

    draw_set_halign(fa_left)
}

if refresh refresh--

if !instance_exists(CoopController) {
    var textremip = (lastpoint == "remoteip" ? "@g" : "@s") + "REMOTE IP: @w" + (global.ip == "127.0.0.1" ? "LOCALHOST" : string(global.ip))
    var textremjoin = (lastpoint == "joinremote" ? "@g" : "@w") + "JOIN REMOTE @d(PORT IS " + string(PORT) + ")"
    var w1 = string_width(textremip)
    var w2 = string_width(textremjoin)
    var h = string_height("A") / 2

    draw_text_nt(4, view_height - 56, textremip)
    draw_text_nt(4, view_height - 36, textremjoin)

    if point_in_rectangle(mx, my, 4, view_height - 56 - h, w1, view_height - 56 + h) {
        if lastpoint != "remoteip" {
            snd_play(sndMenuSelect)
            lastpoint = "remoteip"
        }

        if mouse_check_button_pressed(mb_left) {
            ipprompt = get_string_async("Enter IP:", global.ip)
            snd_play(sndMenuClick)
        }
    }

    if point_in_rectangle(mx, my, 4, view_height - 36 - h, w2, view_height - 36 + h) {
        if lastpoint != "joinremote" {
            snd_play(sndMenuSelect)
            lastpoint = "joinremote"
        }

        if mouse_check_button_pressed(mb_left) {
            join_remote(global.ip)
            snd_play(sndMenuClick)
        }
    }
}

draw_set_valign(fa_top)