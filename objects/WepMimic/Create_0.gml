raddrop = 15
max_hp = 15
meleedamage = 4
size = 0

spr_idle = sprWepMimicIdle
spr_walk = sprWepMimicFire
spr_hurt = sprWepMimicHurt
spr_dead = sprWepMimicDead

event_inherited()

snd_hurt = sndMimicHurt
snd_dead = sndMimicDead
snd_mele = sndMimicMelee

//behavior
alarm[1] = 90 + random(150)

if (place_free(x, y - 12)) move_contact_solid(90, 12)

hitid = HitId.WeaponMimic