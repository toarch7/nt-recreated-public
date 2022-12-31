raddrop = 12
max_hp = 15
meleedamage = 0
size = 1

event_inherited()

spr_idle = sprTurtleIdle
spr_walk = sprTurtleIdle
spr_hurt = sprTurtleHurt
spr_dead = sprTurtleDead
spr_fire = sprTurtleFire

snd_mele = sndTurtleMelee
snd_hurt = sndTurtleHurt
snd_dead = asset_get_index("sndTurtleDead" + string(instance_number(Turtle) % 4 + 1))

if !snd_dead {
    snd_dead = sndTurtleDead1
}

//behavior
walk = 0
alarm[1] = 30 + random(90)