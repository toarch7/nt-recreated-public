raddrop = 30
max_hp = ceil(100 * (1 + GameCont.loops / 3))
if player_count > 1 {
    max_hp = round(max_hp * (1 + player_count / 2))
}

meleedamage = 0
size = 3

spr_idle = sprBanditBossIdle
spr_walk = sprBanditBossWalk
spr_hurt = sprBanditBossHurt
spr_dead = sprBanditBossDead
spr_fire = sprBanditBossFire

event_inherited()

snd_hurt = sndBigBanditHit
snd_dead = sndBigBanditDie

//behavior
ammo = 10
walk = 0
shot = 0
chargewait = 2
charge = 0
gunangle = random_angle
alarm[1] = 1
intro = 0
wkick = 0

scrTarget()

if instance_exists(target) gunangle = mcr_target_direction

sndhalfhp = 0
sndtaunt = 0
tauntdelay = 0

spr_shadow = shd32
spr_shadow_y = 4

hitid = HitId.BigBandit