alarm[1] = 15 + random(5)
scrTarget()

if instance_exists(target) {
    if !collision_line(x, y, target.x, target.y, Wall, 0, 0) {
        gunangle = target_direction
        scrRight(1)

        if (random(4) < 3) && ((freeze > 40) && (point_distance(x, y, target.x, target.y) < 150)) {
            alarm[2] = 5
            ammo = 6
            alarm[1] = 20
        } else if (random(3) < 1) {
            snd_play_hit_big(sndEliteShielderShield, 0.2)
            with instance_create(x, y, EliteShield)
            creator = other.id

            alarm[1] = 85
            speed = 0
            walk = 0
        } else {
            speed = 0.4
            walk = 10 + random(10)
            if freeze < 40 alarm[1] += random(30)

            if point_distance(x, y, target.x, target.y > 64) direction = target_direction + random_range(-25, 25)
            else direction = target_direction + 180 + random_range(-45, 45)
        }
    } else if random(3) < 1 {
        gunangle = random(360)
        walk = 20 + random(10)
        motion_add(gunangle, 0.4)

        scrRight(0)
    } else if (freeze > 40) && (random(4) < 1) {
        snd_play_hit_big(sndEliteShielderShield, 0.2)
        with instance_create(x, y, EliteShield)
        creator = other.id

        alarm[1] = 75
        speed = 0
        walk = 0
    } else if random(10) < 1 && roll == 0 {
        gunangle = random(360)
        motion_add(gunangle, 0.4)
        walk = 20 + random(10)
        alarm[1] = walk + 10 + random(30)

        scrRight(0)
    }
}

/*alarm[1] = 10+random(5)

scrTarget()
if instance_exists(target)
{

if collision_line(x,y,target.x,target.y,Wall,0,0) < 0
{
//SEE TARGET
gunangle = point_direction(x,y,target.x,target.y)
if target.x < x
right = -1
else if target.x > x
right = 1
//SEE PLAYER AND FAR ENOUGH AND NOT SHOUTING "FREEZE MOTHERFUCKER"
if random(2) < 1 and freeze > 40 && distance_to_object(target) <= 250
{
//FIRE
alarm[2] = 2
ammo = 9

alarm[1] = 50
}
else if random(3) < 1
{
//SHIELD
with instance_create(x,y,EliteShield)
target = other.id
snd_play(sndEliteShielderShield)
alarm[1] = 85
speed = 0
walk = 0
}
else
{//JUST WALK YOU KNOW
if point_distance(x,y,target.x,target.y) > 64
direction = point_direction(x,y,target.x,target.y)+random(50)-25
else
direction = point_direction(x,y,target.x,target.y)+180+random(90)-45
speed = 0.4
walk = 10+random(10)
if freeze < 40
alarm[1] += random(30)
}


}
else if random(3) < 1
{
//WALK
motion_add(random(360),0.4)
walk = 20+random(10)
gunangle = direction
if hspeed > 0
right = 1
else if hspeed < 0
right = -1
}
else if freeze > 40 and random(4) < 1 and point_distance(x,y,target.x,target.y) < 96
{
//SHIELD
instance_create(x,y,EliteShield)
alarm[1] = 75
speed = 0
walk = 0
}
}
else if random(10) < 1 and roll = 0
{
//NO TARGET
motion_add(random(360),0.4)
walk = 20+random(10)
alarm[1] = walk+10+random(30)
gunangle = direction
if hspeed > 0
right = 1
else if hspeed < 0
right = -1
}

*/