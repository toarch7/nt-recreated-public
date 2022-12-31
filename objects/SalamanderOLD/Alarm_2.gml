if ammo {
    with instance_create(x + hspeed + lengthdir_x(12, gunangle), y + vspeed + lengthdir_y(12, gunangle), TrapFire) {
        motion_add(other.gunangle, 6)
        image_angle = direction
        creator = other.id
        team = other.team
    }

    gunangle += 6
    sprite_index = spr_fire
    ammo--alarm[2] = 1
} else {
    sprite_index = spr_idle
    alarm[1] = 40 + random(10)
}