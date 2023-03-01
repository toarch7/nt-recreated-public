event_inherited()

if sprite_index != spr_hurt motion_add(direction, 0.6)


if hspeed > 0 right = 1
else if hspeed < 0 right = -1

speed = 2.5

if instance_exists(target) {
    if !close && point_distance(x, y, target.x, target.y) < 64 {
        snd_play(sndFrogClose)
        close = 1
    }
}