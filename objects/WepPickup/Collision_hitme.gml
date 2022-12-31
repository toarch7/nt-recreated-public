if mask_index != mskWepPickup {
    if speed > 4 && team != other.team && instance_exists(Player) {
        with other {
            if !inframes {
                hp -= 15 + 4 * Player.level
                sprite_index = spr_hurt
                snd_play_hit(snd_hurt, .2)
                inframes = 5
            }
        }

        instance_create(x, y, ThrowHit)

        if !skill_get(5) speed *= .2
    }
}