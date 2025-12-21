if lockstep_stop
	exit

scrDrawSpiral()

draw_set_halign(fa_center)
draw_set_valign(fa_top)

if GameCont.crownpoints <= 0 {
    if GameCont.skillpoints <= 1 or (!GameCont.skillpoints && GameCont.ultrapoints) {
        txt = " @gMUTATION"
    }
	else {
        txt = " @gMUTATIONS"
    }

    txt2 = "SELECT "
	
	var _robot_message = false
	
	with Player {
		if scr_player_is_local(index) && race == Race.Robot {
			_robot_message = true
			break
		}
	}
	
    if _robot_message {
        if GameCont.skillpoints <= 1 {
            txt = " @gUPDATE"
        }
		else txt = " @gUPDATES@s#DON'T TURN OFF THE ROBOT"

        txt2 = "INSTALL "
    }
}
else {
    txt = loc("CHOOSE WISELY")
    txt2 = ""
}

if splat {
	if (splatimg < sprite_get_number(sprMutationSplat) - 1) splatimg ++
    draw_sprite(sprMutationSplat, splatimg, view_width / 2, view_height - 31)
}

var spr = sprLevelUpText,
	count = string(GameCont.skillpoints)

if instance_exists(CrownIcon) {
    spr = sprPickCrownText
    count = ""
}
else if instance_exists(UltraIcon) {
    spr = sprLevelUltraText
    count = loc("@gULTRA")
}

var img = appear > view_height * 0.7 ? 0 : 2,
	
	_x = view_xview + view_width / 2 + appear,
	_y = view_yview + 48,
	
	name = scrMenuButtonName(spr, img)

if !loc_exists(name) {
	draw_sprite_ext(spr, img, _x + 1, _y + 1, 1, 1, 0, c_black, 1)
	draw_sprite_ext(spr, img, _x + 1, _y    , 1, 1, 0, c_black, 1)
	draw_sprite_ext(spr, img, _x    , _y + 1, 1, 1, 0, c_black, 1)
	
	draw_sprite(spr, img, _x, _y)
}
else draw_text_bigname(_x, _y, loc(name), img == 0 ? c_white : c_ultra)

draw_text_nt(view_xview + view_width / 2 + 1, view_yview + 75 - appear, "@s" + loc_sfmt(txt2 + "%" + txt, count))

appear = lerp(appear, 0, 0.75)

draw_set_halign(fa_left)
draw_set_valign(fa_top)