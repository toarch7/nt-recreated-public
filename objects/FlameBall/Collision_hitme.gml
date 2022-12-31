if ((other.team != team) && (other.hp > 0)) {
    BackCont.shake += 1
    x -= hspeed
    y -= vspeed
    if (other.sprite_index != other.spr_hurt) {
        with(other) {
            if (object_index == Player) last_hit = other.hit_id
            hp -= other.dmg
            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 32)
            if (speed > 16) speed = 16
        }
    }
    snd_play_hit(other.snd_hurt, 0.2)
}