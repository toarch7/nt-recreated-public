raddrop = 0
max_hp = 40
meleedamage = 0
size = 1

spr_idle = sprEliteInspectorIdle
spr_walk = sprEliteInspectorWalk
spr_hurt = sprEliteInspectorHurt
spr_dead = sprEliteInspectorDead

event_inherited()

snd_hurt = sndEliteInspectorHurt
snd_dead = sndEliteInspectorDead
snd_play_hit_big(sndEliteInspectorEnter, 0.2)

if GameCont.area == 101 {
    snd_hurt = sndOasisHurt
    snd_dead = sndOasisDeath
}

team = 3

//behavior
walk = 30
grenades = 5
gunangle = random(360)
alarm[1] = 30 + random(15)
wkick = 0
control = 0
angle = 0

wepangle = choose(-140, 140)
wepflip = 1

freeze = 0
if instance_exists(Player) {
    lastx = Player.x
    lasty = Player.y
} else {
    lastx = x
    lasty = y
}