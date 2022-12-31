scrTarget()

if !instance_exists(target) {
    alarm[0] = 5 exit
}

var bx1 = x - 213
var by1 = y - 120
var bx2 = x + 213
var by2 = y + 120

x = target.x
y = target.y

if instance_exists(target) {
    var t = target

    with Smoke
    instance_destroy()

    with Wall {
        image_blend = c_white

        if x > bx1 && x < bx2 && y > by1 && y < by2 {
            if !collision_line(x, y, t.x, t.y, Wall, 1, 1) && point_distance(x, y, t.x, t.y) > 100 && point_distance(x, y, t.x, t.y) < 124 && distance_to_object(Wall) <= 2 && (place_meeting(x + 16, y, Floor) or place_meeting(x - 16, y, Floor) or
            place_meeting(x, y + 16, Floor) or place_meeting(x, y - 16, Floor)) {
                instance_create(x, y, CanSpawnBoss)
            }
        }
    }

    if instance_exists(CanSpawnBoss) {
        with instance_nearest(target.x + random(60) - 30, target.y + random(60) - 30, CanSpawnBoss)
        instance_create(x + random(4) - 2, y + random(4) - 2, BanditBoss)

        with CanSpawnBoss {
            instance_destroy()
        }

        number--

        if !number {
            instance_destroy()
        }
    }
}

alarm[0] = 1