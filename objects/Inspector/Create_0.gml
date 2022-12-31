raddrop = 0
max_hp = 10
meleedamage = 0
size = 1

spr_idle = sprInspectorIdle
spr_walk = sprInspectorWalk
spr_hurt = sprInspectorHurt
spr_dead = sprInspectorDead

event_inherited()

snd_hurt = sndInspectorHurt
snd_dead = sndInspectorDead

male = 1

if irandom(1) {
    snd_hurt = sndInspectorHurtF
    snd_dead = sndInspectorDeadF
    snd_play_hit_big(sndInspectorEnterF, 0.2)
    male = 0
} else {
    snd_play_hit_big(sndInspectorEnter, 0.2)
}

if GameCont.area == 101 {
    snd_hurt = sndOasisHurt
    snd_dead = sndOasisDeath
}

team = 3

//behavior
walk = 0
grenades = 4
gunangle = random(360)
alarm[1] = 30 + random(15)
wkick = 0
control = 0
angle = 0

freeze = 0
if instance_exists(Player) {
    lastx = Player.x
    lasty = Player.y
} else {
    lastx = x
    lasty = y
}