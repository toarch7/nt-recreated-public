raddrop = 8
max_hp = 12
meleedamage = 0
size = 1
corpse = 1
spr_idle = sprGatorIdle
spr_walk = sprGatorWalk
spr_hurt = sprGatorHurt
spr_dead = sprGatorDead

event_inherited()


snd_hurt = sndGatorHit
snd_dead = sndGatorDie

//behavior
walk = 0
gunangle = random(360)
alarm[1] = 30 + random(90)
wkick = 0

if instance_exists(Player) {
    if random(30) < GameCont.hard {
        instance_create(x, y, BuffGator)
        instance_change(Wind, 0)
    }
}