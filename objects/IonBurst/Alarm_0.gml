ammo -= 1

alarm[0] = time


if instance_exists(creator) {
    x = creator.x
    y = creator.y
    //FIRING
    snd_play(sndLaser)

    if place_meeting(mouse_x, mouse_y, Floor) {
        with instance_create(mouse_x, mouse_y, PlasmaImpact) {
            hit_id = other.hit_id
            team = other.team
            with hitme {
                if place_meeting(x, y, other) {
                    hp -= 2
                }
            }
        }
    }

    BackCont.shake += 3
    creator.wkick = 6
}


if ammo = 0 instance_destroy()