max_hp = 120
max_hp *= 1 + (GameCont.loops / 10)
size = 4
charged = 0
rad = GameCont.crownrad
anim = 0
canim = 0
spr_idle = sprPStat1Idle
spr_hurt = sprPStat1Hurt
spr_dead = sprPStatDead
event_inherited()
team = 1
snd_hurt = sndStatueHurt
snd_dead = sndStatueDead

spr_shadow = shd64
spr_shadow_y += 9

instance_create(x - 16, y - 16 - 32, Floor)
instance_create(x - 16, y - 16 + 32, Floor)
instance_create(x - 16 - 32, y - 16, Floor)
instance_create(x - 16 + 32, y - 16, Floor)
instance_create(x - 16 - 32, y - 16 - 32, Floor)
instance_create(x - 16 - 32, y - 16 + 32, Floor)
instance_create(x - 16 + 32, y - 16 - 32, Floor)
instance_create(x - 16 + 32, y - 16 + 32, Floor)

with Wall {
    if place_meeting(x, y, other) {
        instance_create(x, y, FloorExplo)
        instance_destroy()
    }
}

/*
with Floor {
    if point_distance(x+16,y+16,other.x,other.y) < 34
    sprite_index = sprFloor100
}*/

instance_create(x, y, PortalClear)

repeat 4 {
    instance_create(((x + random(12)) - 6), ((y + random(12)) - 6), Bandit)
}