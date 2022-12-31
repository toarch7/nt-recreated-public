speed = 0

scrDrop(0, 10)

instance_create(x, y, PortalClear)

event_inherited()

if charge {
    ang = random(360)
    repeat 14 {
        with instance_create(x, y, ExploguardianBullet) {
            team = other.team
            motion_add(other.ang, 4)
            image_angle = direction
            hit_id = other.spr_idle
        }

        ang += 24
    }

    snd_play_hit(sndExploGuardianDeadCharge, .2)
}