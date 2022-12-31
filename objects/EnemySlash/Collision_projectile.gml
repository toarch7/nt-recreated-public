if team != other.team {

    if other.typ = 1 {
        other.direction = image_angle
        other.image_angle = other.direction
    }
    if other.typ = 2 {
        with other
        instance_destroy()
    }

}