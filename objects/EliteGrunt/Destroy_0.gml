scrDrop(80, 0)

event_inherited()

if GameCont.race == 12 {
	UberCont.ctot_uniq[12] ++
}

with Grunt
freeze += 100
with Inspector
freeze += 101
with Shielder
freeze += 100
with EliteGrunt
freeze += 100
with EliteInspector
freeze += 100
with EliteShielder
freeze += 100

with WantVan
canspawn = 1

if GameCont.area == 101 {
    with instance_create(x, y, AnimParticle)
    sprite_index = sprPlayerBubblePop
}