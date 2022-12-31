with other {
    direction = other.direction
    speed = 12

    friction = 0.1
    alarm[1] = 6

    BackCont.shake += 3

    with instance_create(x, y, Deflect)
    image_angle = other.direction
}