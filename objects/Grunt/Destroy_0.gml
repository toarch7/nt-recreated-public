scrDrop(20, 0)

event_inherited()

with Grunt {
    freeze += 100
}
with Shielder {
    freeze += 100
}
with Inspector {
    freeze += 100
}

with WantVan
canspawn = 1

if GameCont.area == 101 {
    with instance_create(x, y, AnimParticle)
    sprite_index = sprPlayerBubblePop
}