raddrop = 10
max_hp = 16
meleedamage = 5
size = 2

spr_idle = sprScorpionIdle
spr_walk = sprScorpionWalk
spr_hurt = sprScorpionHurt
spr_dead = sprScorpionDead
spr_fire = sprScorpionFire

event_inherited()


snd_hurt = sndScorpionHit
snd_dead = sndScorpionDie
snd_mele = sndScorpionMelee

//behavior
ammo = 10
walk = 0
gunangle = random(360)
alarm[1] = 30 + random(90)

if instance_exists(Player) {
    if random(60) < GameCont.hard and GameCont.subarea > 1 {
        instance_create(x, y, GoldScorpion)
        instance_change(Wind, 0)
    }
}

spr_shadow = shd32
spr_shadow_y = 4