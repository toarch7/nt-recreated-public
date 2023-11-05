raddrop = 10
max_hp = 50
meleedamage = 0
size = 2

spr_idle = sprSnowTankIdle
spr_walk = sprSnowTankWalk
spr_hurt = sprSnowTankHurt
spr_dead = sprSnowTankDead

event_inherited()
corpse = 0

snd_hurt = sndSnowTankHurt
snd_dead = sndSnowTankDead

//behavior
alarm[1] = 30 + random(10)
ammo = 0
gunangle = random_angle
rest = 0
wave = 0

spr_shadow = shd32
spr_shadow_y = 3


var rand = 40

if GameCont.crown == 7
    rand *= 0.7

if random(rand) < (1 + GameCont.loops * 5) && GameCont.subarea > 1 {
    instance_create(x, y, GoldSnowTank)
    instance_destroy(id, 0)
}