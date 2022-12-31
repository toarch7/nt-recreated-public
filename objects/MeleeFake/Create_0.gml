image_index = 0


raddrop = 8
max_hp = 8
meleedamage = 1
size = 1
target = -1
spr_idle = sprite_index
spr_hurt = sprMeleeHurt
spr_dead = sprMeleeDead
spr_walk = sprite_index

event_inherited()

snd_hurt = sndAssassinHit
snd_dead = sndAssassinDie

image_speed = 0

if GameCont.area == 105 {
    spr_idle = sprJungleAssassinHide
    spr_hurt = sprJungleAssassinHurt
    spr_dead = sprJungleAssassinDead
    spr_walk = sprJungleAssassinHide
}

sprite_index = spr_idle

//behavior
walk = 0
gunangle = random(360)
wepangle = choose(-140, 140)
wepflip = 1

friction = 0.4
right = choose(1, - 1)
hp = max_hp

if instance_exists(Player) {
    if skill_get(11) hp = round(hp * 0.8)
}


team = 1
target = -1

snd_hurt = sndHitFlesh
snd_dead = sndEnemyDie