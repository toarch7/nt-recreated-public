if team != other.team {

    if other.typ = 1 {
        other.team = team
        other.direction = point_direction(other.x, other.y, other.xstart, other.ystart)
        other.image_angle = other.direction
        other.speed /= 2
    }
    if other.typ = 2 {
        with other
        instance_destroy()
    }

}