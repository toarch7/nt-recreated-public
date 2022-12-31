var ang = random(360)

repeat 6 {
    with instance_create(x, y, Maggot) {
        givekill = 0
        motion_add(ang, 4)
        move_contact_solid(ang, random(4))
        if instance_exists(Portal) {
            hp = 0
        }
    }

    ang += 60
}