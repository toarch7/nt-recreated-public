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

with EliteShield {
    if creator != other.id
    continue

    alarm[0] = -1
    sprite_index = sprEliteShielderShieldDisappear
    image_index = 0
    image_speed = 0.4
}

if GameCont.area == 101 {
    with instance_create(x, y, AnimParticle)
    sprite_index = sprPlayerBubblePop
}