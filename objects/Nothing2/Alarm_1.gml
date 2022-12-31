alarm[1] = 10
scrTarget()

if instance_exists(target) {
    if attack == 1 {
        shots += 1

        snd_play_hit_big(sndBigballFire, 0.1)
        aimdir = target_direction + ((30 + random(10)) * side)

        with instance_create(x, y, BigGuardianBullet) {
            hit_id = other.spr_idle
            motion_add(other.aimdir, 5 + random(1))
            team = other.team
        }

        side = (-side)
        if shots == 2 + GameCont.loops {
            shots = 0
            alarm[1] += 100
            attack = choose(1, 2, 3)
            exit
        }
    }
    if (attack == 2) {
        if instance_exists(target) {
            x += lengthdir_x(1.5, target_direction)
            y += lengthdir_y(1.5, target_direction)
        }
        repeat(10 + GameCont.loops) {
            with(instance_create(x, y, GuardianBullet)) {
                hit_id = other.spr_idle
                motion_add(other.aimdir, 8)
                if (hspeed > 0) image_xscale = 1
                else image_xscale = -1
                team = other.team
            }
            aimdir += (360 / (10 + GameCont.loops))
        }
        walk = 0
        if (shots == 0) snd_play_hit(sndExploGuardianFire, 0)
        shots += 1
        alarm[1] = 2
        if (shots == (15 + (GameCont.loops * 5))) {
            shots = 0
            alarm[1] += 40
            aimdir = random(360)
            attack = choose(1, 3)
            exit
        }
    }
    if (attack == 3) {
        snd_play_hit_big(sndNothing2Ball, 0.1)
        ang = random(360)
        repeat(4 + GameCont.loops) {
            with(instance_create(x, y, Throne2Ball)) {
                hit_id = other.spr_idle
                motion_add(other.ang, (4 + random(6)))
                speed = (4 + random(6))
                other.ang += (360 / (4 + GameCont.loops))
                team = other.team
            }
        }
        side = (-side)
        shots = 0
        alarm[1] += 90
        attack = choose(1, 2, 3)
        exit
    }
}
alarm[1] /= (2 - (hp / max_hp))