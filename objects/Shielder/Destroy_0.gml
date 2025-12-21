scrDrop(20, 0)

event_inherited()

scrOnPopoKill()

with PopoShield {
    if creator == other.id {
        sprite_index = sprShielderShieldDisappear
        image_speed = 0.4
        image_index = 0
    }
}

if GameCont.underwater {
    with (instance_create(x, y, AnimParticle)) sprite_index = sprPlayerBubblePop
}