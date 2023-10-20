with instance_create(x, y, EBulletHit)
sprite_index = sprGuardianBulletHit

snd_play(sndBigballBreak)

instance_create(x, y, PortalClear)

with ThroneStatue {
    if distance_to_object(other) <= 32 && instance_exists(Nothing) {
        instance_destroy()
    }
}

if place_meeting(x, y, Floor) scrDrop(50, 0)

var ang = random_angle
var n = 360 / (7 + GameCont.loops)
var spd = 2

repeat 4 {
    repeat 7 + GameCont.loops {
        with instance_create(x, y, GuardianBullet) {
            sprite_index = sprGuardianBullet

            motion_add(ang, spd)
            team = other.team

            typ = 2

            hit_id = other.hit_id
        }

        ang += n
    }

    spd += 0.5
}

with BackCont shake += 5