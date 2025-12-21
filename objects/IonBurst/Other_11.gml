/// @description Fire shots

var _tx = creator.x,
	_ty = creator.y

with creator {
	if instance_exists(aimassist_target) {
		with aimassist_target {
			_tx = x
			_ty = y
		}
	}
	else if is_keyboard(index) {
		_tx = x + ldrx(KeyCont.dis_fire[index], KeyCont.dir_fire[index])
		_ty = y + ldry(KeyCont.dis_fire[index], KeyCont.dir_fire[index])
	}
	else {
		_tx = crosshair_x
		_ty = crosshair_y
	}
}

x = _tx
y = _ty

//FIRING
var _laser_brain = scr_skill_get(mut_laser_brain)

snd_play(_laser_brain ? sndLaserUpg : sndLaser)

if place_meeting(x, y, Floor) {
	var _damage = 2 * (1 + _laser_brain)
    with scr_damage_create(x, y, PlasmaImpact) {
        with hitme {
            if place_meeting(x, y, other) && scr_can_hit(id, false, other.id) {
				scr_hit_self(_damage, other.hitid)
			}
		}
    }
}

scr_weapon_post(direction, 0, 6, 3)