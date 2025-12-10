event_inherited()

snd_play_hit_big(sndBigBallExplo)

instance_create(x, y, PortalClear)

if place_meeting(x, y, Floor) scrDrop(50, 0)

var _ang = random_angle,
	_count = 7 + GameCont.loops,
	_n = 360 / _count,
	_spd = 2

repeat 4 {
    repeat _count {
        with scr_projectile_create(x, y, GuardianBullet, _ang, _spd) {
            sprite_index = sprGuardianBullet
            typ = 2
        }

        _ang += _n
    }

    _spd += 0.5
}

scr_screenshake(5)