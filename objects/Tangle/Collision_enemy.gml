with other {
    x = xprevious + hspeed * 0.1
    y = yprevious + vspeed * 0.1

    if place_meeting(x, y, Wall) {
        x = xprevious
        y = yprevious
    }

    if instance_exists(Player) {
        if skill_get(5) {
            if hp <= max_hp / 3 {
                hp = 0
                motion_add(point_direction(Player.x, Player.y, x, y), 5)

                with instance_create(x, y, AnimParticle) {
                    sprite_index = sprTangleKill
                    image_speed = 0.4
                }
            }
        }
    }
}