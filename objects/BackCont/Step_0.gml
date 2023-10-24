if lockstep_stop
	exit

if !instance_exists(LevCont) && !instance_exists(CrownIcon) && !(instance_exists(SpiralCont) && !instance_exists(NothingSpiral)) && !instance_exists(GenCont) {
    var dir = 0
    var dis = 0
    var dir2 = 0
    var dis2 = 0
    var o = noone
    var viewdist = 4

    if instance_exists(Cinematic) {
        with Cinematic {
            view_xview = lerp(view_xview, (x - view_width / 2), 0.1)
            view_yview = lerp(view_yview, (y - view_height / 2), 0.1)
        }

        view_xview = round(view_xview)
        view_yview = round(view_yview)

        camera_set_view_pos(view_camera, view_xview, view_yview)

        exit
    }

    if instance_exists(Portal) o = Portal
    else if instance_exists(BecomeNothing) o = BecomeNothing
    else if instance_exists(BecomeNothing) o = Nothing2Appear
    else if instance_exists(NothingDeath) o = NothingDeath
    else if instance_exists(Nothing2Death) o = Nothing2Death
    else if instance_exists(SitDown) o = SitDown
	
	if instance_exists(TutCont) && instance_exists(WeaponChest)
		o = WeaponChest

    with Player
    if index == global.index {
        if wep_type[wep] == 0 viewdist = 8
        if wep_type[wep] == 3 viewdist = 3
		
		if UberCont.opt_camera {
	        if instance_exists(o) {
	            var i = instance_nearest(x, y, o)
	            dis = point_distance(x, y, i.x, i.y) / 6
	            dir = point_direction(x, y, i.x, i.y)
				
	            if o == Portal or instance_is(o, WeaponChest) {
	                dis = min(dis, 72)
	            }
	        }
			
	        if !UberCont.localcoop {
	            dir2 = KeyCont.dir_fire[index]
				
	            if UberCont.opt_gamepad {
	                var gpx = gamepad_axis_value(0, gp_axisrh)
	                var gpy = gamepad_axis_value(0, gp_axisrv)
	                dis2 = (point_distance(0, 0, gpx, gpy) * 72) / viewdist
	            }
				else if UberCont.opt_keyboard {
	                dis2 = point_distance(x, y, mouse_x, mouse_y) / viewdist
	            }
				else if instance_exists(JoystickAttack) {
	                if !save_get_value("contorls", "aimbot", 0) {
	                    dir2 = KeyCont.dir_fire[global.index]
	                    dis2 = JoystickAttack.vdis / viewdist
	                }
	            }
	        }
		}

        if !bleed {
            view_xview = lerp(view_xview, (x - view_width / 2 + other.viewx2 + (random(other.shake) - other.shake / 2) * UberCont.opt_shake) + lengthdir_x(dis, dir) + lengthdir_x(dis2, dir2), 0.4)
            view_yview = lerp(view_yview, (y - view_height / 2 + other.viewy2 + (random(other.shake) - other.shake / 2) * UberCont.opt_shake) + lengthdir_y(dis, dir) + lengthdir_y(dis2, dir2), 0.4)
        }
    }
}

viewx2 = round(viewx2 - viewx2 * 0.4)
viewy2 = round(viewy2 - viewy2 * 0.4)

if UberCont.opt_shake <= 0 {
    shake = 0
    viewx2 = 0
    viewy2 = 0
}

if shake > 10 {
    shake = shake * 0.8
} else if shake > 0 {
    shake--

    if !shake { //set to 0 in case of decimal screenshake
        shake = 0
    }
}

if !instance_exists(Cinematic) {
    if instance_exists(FloorMaker) && instance_exists(Player) {
        view_xview = Player.x - view_width / 2
        view_yview = Player.y - view_width / 2
    }
}

view_xview = round(view_xview)
view_yview = round(view_yview)