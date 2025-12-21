if lockstep_stop
	exit

if fainted {
	draw_self()
	exit
}

wave += 0.4

if wave > 6.2 {
	wave -= 6.2
}

if race == Race.Eyes {
	var _img = current_frame * 0.4
	
	if KeyCont.hold_spec[index] {
		var _sprite = scr_skill_get(mut_throne_butt) ? sprMindPowerTB : sprMindPower
		draw_sprite_ext(_sprite, _img % 3, x, y, right, 1, angle, c_white, 1)
	}
	else if scr_ultra_get(Race.Eyes, UltraSkill.MonsterStyle) {
		draw_sprite_ext(sprEyesB, _img % 6, x, y, right, 1, angle, 0xccfbc7, 1)
	}
}

if wep_type[wep] == 0 {
	wepright = wepflip
}
else wepright = right

if wep_type[bwep] == 0 {
	bwepright = bwepflip
}
else bwepright = right

var _backwep_angle = 90

if max_extra_weps > 0 && array_length(extra_weps) {
	var _count = array_length(extra_weps)
	
	_backwep_angle -= 5 * right
	
	for(var i = 0; i < _count; ++i) {
		draw_sprite_ext(wep_sprt[extra_weps[i]], 0, x - right * (2 + i), y + swapanim,
			1, bwepright, _backwep_angle, merge_color(c_silver, c_black, i / _count), 1)
		
		_backwep_angle += (15 + i) * right
	}
}

if bwep != 0 && race != Race.Steroids {
	draw_sprite_ext(wep_sprt[bwep], 0, x - right * 2, y + swapanim,
		1, bwepright, _backwep_angle + 15 * right, c_silver, 1)
}

var _is_shielding = false

if race == Race.Crystal && !fainted && instance_exists(CrystalShield) {
	with CrystalShield {
		if creator == other.id && sprite_index != spr_disappear {
			_is_shielding = true; break
		}
	}
}

if wep_type[wep] == Ammo.Bolts && is_me && !_is_shielding && wep != wep_disc_gun {
    lasx = x
    lasy = y
    lasd = 0

    do {
        lasd ++
		
		lasx += lengthdir_x(2, gunangle)
        lasy += lengthdir_y(2, gunangle)
    }
	until position_meeting(lasx, lasy, Wall) or lasd > 1000

    draw_sprite_ext(sprLaserSightPlayer, -1, x, y, point_distance(x, y, lasx, lasy) / 2 + 2, 1, gunangle, c_white, 1)
}

//DUAL WIELDING
if race == Race.Steroids && bwep != 0 && is_me {
    if wep_type[bwep] == Ammo.Bolts && bwep != wep_disc_gun {
        lasx = x
        lasy = y - 4
        lasd = 0

        do {
            lasd++lasx += lengthdir_x(2, gunangle)
            lasy += lengthdir_y(2, gunangle)
        } until position_meeting(lasx, lasy, Wall) or lasd > 1000

        draw_sprite_ext(sprLaserSightPlayer, -1, x, y - 4, point_distance(x, y, lasx, lasy) / 2 + 2, 1, gunangle, c_white, 1)
    }

    draw_sprite_ext(wep_sprt[bwep], 0, x + lengthdir_x(-bwkick, gunangle + (bwepangle * (1 - wkick / 20))), y - 4 + lengthdir_y(-bwkick, gunangle + (bwepangle * (1 - wkick / 20))), 1, -bwepright, gunangle + (bwepangle * (1 - wkick / 20)), c_white, 1)
}

//DRAW DA GUNZ

var _shining_finger = trigger_fingers_shine

if back && !_is_shielding && wep {
	draw_sprite_ext(wep_sprt[wep], max(0, _shining_finger),
		x + lengthdir_x(-wkick, gunangle + (wepangle * (1 - wkick / 20))),
		y + lengthdir_y(-wkick, gunangle + (wepangle * (1 - wkick / 20))) - swapanim,
	1, wepright, gunangle + (wepangle * (1 - wkick / 20)), c_white, 1)
}

if instance_exists(CoopController) && UberCont.opt_outlines {
	var pinst = scr_playerinstance_find(index)
	
	if pinst {
		gpu_set_fog(true, pinst.color, 0, 0)
		
	    draw_sprite_ext(sprite_index, image_index, x - 1, y, right, 1, angle, c_white, 1)
	    draw_sprite_ext(sprite_index, image_index, x + 1, y, right, 1, angle, c_white, 1)
	    draw_sprite_ext(sprite_index, image_index, x, y - 1, right, 1, angle, c_white, 1)
	    draw_sprite_ext(sprite_index, image_index, x, y + 1, right, 1, angle, c_white, 1)
		
	    gpu_set_fog(0, 0, 0, 0)
	}
}

draw_sprite_ext(sprite_index, -1, x, y, right, 1, angle, c_white, 1)

if !back && !_is_shielding && wep {
	draw_sprite_ext(wep_sprt[wep], max(0, trigger_fingers_shine),
		x + lengthdir_x(-wkick, gunangle + (wepangle * (1 - wkick / 20))),
		y + lengthdir_y(-wkick, gunangle + (wepangle * (1 - wkick / 20))),
	1, wepright, gunangle + (wepangle * (1 - wkick / 20)), c_white, 1)
}

wkick = approach(wkick, 0, timescale)

if race == Race.Steroids {
    bwkick = approach(bwkick, 0, timescale)
}

if instance_exists(GameCont) && GameCont.underwater && race != 1 && race != 8 {
    draw_sprite(sprPlayerBubble, -1, x, y)
}

if infammo {
    draw_sprite(sprGunWarrant, infammo * 0.4, x, y)
}
