image_index = 1
image_speed = 0

repeat(3) {
    with instance_create(x, y, Smoke)
    motion_add(random_angle, random(2))
}

var max_steps = 50
while max_steps > 0 {
    max_steps--xprevious = x
    yprevious = y
    x += lengthdir_x(16, direction)
    y += lengthdir_y(16, direction)
    var hit = instance_place(x, y, hitme)
    if place_meeting(x, y, Wall) or (hit && hit.team != team) {
        x = xprevious
        y = yprevious
        break
    } else if irandom(2) {
        with instance_create(x, y, Smoke) {
            motion_add(random_angle, random(2))
        }
    }
}