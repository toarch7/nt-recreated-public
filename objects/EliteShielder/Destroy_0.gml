scrDrop(20, 0)

event_inherited()

scrOnPopoKill()

with EliteShield {
    if (creator != other.id) continue
	
    alarm[0] = -1
    sprite_index = sprEliteShielderShieldDisappear
    image_index = 0
    image_speed = 0.4
}

scrBubblePopFX()