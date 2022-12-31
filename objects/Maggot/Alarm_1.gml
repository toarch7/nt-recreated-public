scrTarget()
alarm[1] = 30 + random(20)
if target > 0 {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 direction = target_direction + random(20) - 10
    else motion_add(random(360), 0.5)
} else motion_add(random(360), 0.5)

if place_meeting(x, y, Wall) {
    var f = instance_nearest(x, y, Floor)

    if f {
        x = f.x + f.sprite_width / 2
        y = f.y + f.sprite_height / 2
    }
}