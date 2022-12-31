if image_speed > 0 exit

if team != other.team {
    if other.typ == 1 {
        other.team = team
        other.direction = point_direction(x, y, other.x, other.y)
        other.image_angle = other.direction
        with instance_create(other.x, other.y, Deflect)
        image_angle = other.direction
        other.hit_id = sprEliteShielderIdle
    }

    if other.typ = 2 {
        with other
        instance_destroy()
    }

    snd_play(sndCrystalDeflect)
}