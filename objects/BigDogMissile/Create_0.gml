raddrop = 0
max_hp = 22
meleedamage = 5
size = 1

spr_idle = sprScrapBossMissileIdle
spr_walk = sprScrapBossMissileIdle
spr_hurt = sprScrapBossMissileHurt
spr_dead = sprScrapBossMissileDead

event_inherited()

creator = noone
target = noone

raddrop = 0
givekill = 0
spr_shadow_y = 3
//alarm[2] = 1

if scr_ultra_get(Race.BigDog, UltraSkill.UltraMissiles) {
    alarm[0] = max(1, 7)
}

hitid = HitId.BigDogMissile