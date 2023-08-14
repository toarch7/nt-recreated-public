event_inherited()
wkick = 0
image_speed = 0.4
friction = 0.4
right = choose(1, - 1)

max_hp *= 1 + GameCont.loops / 20
hp = max_hp

inframes = 0
gunangle = 0

canmelee = 1

if skill_get(11) {
    hp = round(hp * 0.8)
	max_hp = min(hp, max_hp)
}

if global.hardmode {
    raddrop = floor(raddrop / 2)
}

if GameCont.crown == 7 {
    raddrop--
}

//CROWN OF LUCK
if GameCont.crown == 10 && random(1) <= 0.1 && object_index != BanditBoss && object_index != ScrapBoss && object_index != LilHunter && object_index != Nothing && object_index != Nothing2 && object_index != BallMum && object_index != HyperCrystal && object_index != TechnoMancer && object_index != Last {
    hp = 1
}

team = 1
target = noone
hit_id = spr_idle

givekill = 1
corpse = 1

snd_hurt = sndHitFlesh
snd_dead = sndEnemyDie
snd_mele = sndMaggotBite

dropseed = rng_next_int(RNGSlot.Drops)