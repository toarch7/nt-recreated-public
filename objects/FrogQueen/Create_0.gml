raddrop = 30
max_hp = ceil(490 * (1 + GameCont.loops / 3))
meleedamage = 10
size = 3

spr_idle = sprFrogQueenIdle
spr_walk = sprFrogQueenWalk
spr_hurt = sprFrogQueenHurt
spr_dead = sprFrogQueenDead
spr_fire = sprFrogQueenFire

hit_id = spr_idle

event_inherited()

snd_hurt = sndBallMamaHurt
snd_dead = sndBallMamaDead1

corpse = 0

//behavior
walk = 0
gunangle = random_angle
alarm[1] = 60
intro = 0

scrTarget()

if target != -1 {
    gunangle = target_direction
}

sndlowhp = 0
sndhalfhp = 0
sndtaunt = 0
tauntdelay = 0
ammo = 0

motion_add(random_angle, 2)

instance_create(x, y, PortalClear)
instance_create(x, y - 24, PortalClear)
instance_create(x, y + 24, PortalClear)
instance_create(x - 24, y, PortalClear)
instance_create(x + 24, y, PortalClear)

hit_id = spr_idle
friction = 0

spr_shadow = shd64
spr_shadow_y = 8