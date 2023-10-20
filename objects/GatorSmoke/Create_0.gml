raddrop = 8
max_hp = 12
meleedamage = 0
size = 1

spr_idle = sprGatorIdleSmoke
spr_walk = sprGatorWalk
spr_hurt = sprGatorHurt
spr_dead = sprGatorDead

event_inherited()

//behavior
walk = 0
gunangle = random_angle
alarm[1] = 30 + random(90)
wkick = 0
timer = 0

image_speed = 0.4
friction = 0.4
right = choose(1, - 1)
hp = max_hp

if instance_exists(Player) {
    if skill_get(11) hp = round(hp * 0.8)
}


team = 1
wkick = 0
target = -1
givekill = 1

snd_hurt = sndGatorHit
snd_dead = sndGatorDie