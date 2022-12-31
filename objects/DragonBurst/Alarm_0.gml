ammo -= 1

alarm[0] = time

if instance_exists(creator) {
    x = creator.x
    y = creator.y
    direction = creator.direction
    //snd_play(sndJackHammer)
    //FIRING

    repeat(2) {
        with instance_create(x, y, Flame) {
            motion_add(other.creator.gunangle + random(10) - 5, 10 + random(3))
            team = other.team
            move_contact_solid(direction, 14)
        }
    }
    repeat(2) {
        with instance_create(x, y, Flame) {
            motion_add(other.creator.gunangle + random(10) - 5 + 8, 9 + random(3))
            team = other.team
            move_contact_solid(direction, 14)
        }
    }

    repeat(2) {
        with instance_create(x, y, Flame) {
            motion_add(other.creator.gunangle + random(10) - 5 - 8, 9 + random(3))
            team = other.team
            move_contact_solid(direction, 14)
        }
    }


    BackCont.viewx2 += lengthdir_x(3, point_direction(x, y, mouse_x, mouse_y) + 180) * UberCont.opt_shake
    BackCont.viewy2 += lengthdir_y(3, point_direction(x, y, mouse_x, mouse_y) + 180) * UberCont.opt_shake
    BackCont.shake += 1
    wkick = 4
}


if ammo = 0 instance_destroy()