if place_meeting(x, y, Floor) scrDrop(100, 0)
snd_play(sndBigballBreak)
instance_create(x, y, PortalClear)
ang = random_angle
spd = 4
repeat(8) {
    repeat(10) {
        with(instance_create(x, y, IDPDBullet)) {
            hit_id = sprLastIdle
            motion_add(other.ang, other.spd)
            image_angle = direction
            team = 1
        }
        ang += 36
    }
    spd += 0.6
}