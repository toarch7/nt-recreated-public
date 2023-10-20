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

if GameCont.subarea > 1 && !random(40 - GameCont.hard) {
    instance_create(x, y, GoldSnowTank)
    instance_destroy(id, 0)
}