scrDrop(200, 0)
scrDrop(200, 0)
event_inherited()

if GameCont.underwater {
    with instance_create(x, y, AnimParticle) sprite_index = sprPlayerBubblePop
}