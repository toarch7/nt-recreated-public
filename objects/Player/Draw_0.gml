if lockstep_stop
	exit

if fainted {
	draw_self(); exit
}

wave += 0.4

if wave > 6.2
	wave -= 6.2

if race == 3 {
	var img = GameCont.tottimer * 0.4
	
	if KeyCont.hold_spec[index] {
		draw_sprite_ext(skill_get(5) ? sprMindPowerTB : sprMindPower, img, x, y, right, 1, angle, c_white, 1)
	}
	else if ultra == 2 {
		draw_sprite_ext(sprEyesB, img % 6, x, y, right, 1, angle, 0xccfbc7, 1)
	}
}

if wep_type[wep] = 0
	wepright = wepflip
else wepright = right

if wep_type[bwep] = 0 bwepright = bwepflip
else bwepright = right

if bwep != 0 and race != 7 draw_sprite_ext(wep_sprt[bwep], 0, x - right * 2, y, 1, bwepright, 90 + 15 * right, c_silver, 1)

var shielding = false

if race == 2 && !fainted && instance_exists(CrystalShield) {
	with CrystalShield {
		if creator == other.id && sprite_index != spr_disappear {
			shielding = true; break
		}
	}
}

if wep_type[wep] == 3 && is_me && !shielding && wep != 18 {
    lasx = x
    lasy = y
    lasd = 0

    do {
        lasd ++
		
		lasx += lengthdir_x(2, gunangle)
        lasy += lengthdir_y(2, gunangle)
    }
	until position_meeting(lasx, lasy, Wall) or lasd > 1000

    draw_sprite_ext(sprLaserSightPlayer, - 1, x, y, point_distance(x, y, lasx, lasy) / 2 + 2, 1, gunangle, c_white, 1)
}

//DUAL WIELDING
if race == 7 && bwep != 0 && is_me {
    if wep_type[bwep] = 3 and bwep != 18 {
        lasx = x
        lasy = y - 4
        lasd = 0

        do {
            lasd++lasx += lengthdir_x(2, gunangle)
            lasy += lengthdir_y(2, gunangle)
        } until position_meeting(lasx, lasy, Wall) or lasd > 1000

        draw_sprite_ext(sprLaserSightPlayer, - 1, x, y - 4, point_distance(x, y, lasx, lasy) / 2 + 2, 1, gunangle, c_white, 1)
    }

    draw_sprite_ext(wep_sprt[bwep], 0, x + lengthdir_x(-bwkick, gunangle + (bwepangle * (1 - wkick / 20))), y - 4 + lengthdir_y(-bwkick, gunangle + (bwepangle * (1 - wkick / 20))), 1, - bwepright, gunangle + (bwepangle * (1 - wkick / 20)), c_white, 1)
}

//DRAW DA GUNZ

if back = 1 && !shielding && wep draw_sprite_ext(wep_sprt[wep], max(0, fingers), x + lengthdir_x(-wkick, gunangle + (wepangle * (1 - wkick / 20))), y + lengthdir_y(-wkick, gunangle + (wepangle * (1 - wkick / 20))), 1, wepright, gunangle + (wepangle * (1 - wkick / 20)), c_white, 1)

if instance_exists(CoopController) && UberCont.opt_outlines {
	var pinst = player_get(index)
	
	if pinst {
		gpu_set_fog(true, pinst.color, 0, 0)
		
	    draw_sprite_ext(sprite_index, image_index, x - 1, y, right, 1, angle, c_white, 1)
	    draw_sprite_ext(sprite_index, image_index, x + 1, y, right, 1, angle, c_white, 1)
	    draw_sprite_ext(sprite_index, image_index, x, y - 1, right, 1, angle, c_white, 1)
	    draw_sprite_ext(sprite_index, image_index, x, y + 1, right, 1, angle, c_white, 1)
		
	    gpu_set_fog(0, 0, 0, 0)
	}
}

draw_sprite_ext(sprite_index, - 1, x, y, right, 1, angle, c_white, 1)

if back = -1 && !shielding && wep draw_sprite_ext(wep_sprt[wep], max(0, fingers), x + lengthdir_x(-wkick, gunangle + (wepangle * (1 - wkick / 20))), y + lengthdir_y(-wkick, gunangle + (wepangle * (1 - wkick / 20))), 1, wepright, gunangle + (wepangle * (1 - wkick / 20)), c_white, 1)

if wkick > 0
	wkick --

if wkick < 0
	wkick ++

if race = 7 {
    if bwkick > 0
		bwkick --
	
    if bwkick < 0
		bwkick ++
}

if instance_exists(GameCont) && GameCont.area == 101 && race != 1 && race != 8
    draw_sprite(sprPlayerBubble, - 1, x, y)

if infammo
    draw_sprite(sprGunWarrant, infammo * 0.4, x, y)
