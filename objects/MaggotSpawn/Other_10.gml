event_inherited()

speed = 0
scrTarget()
if instance_exists(target) {
    if distance_to_object(target) < 64 and sprite_index != spr_hurt and sprite_index != spr_chrg {
        hp -= 1
        sprite_index = spr_chrg
        image_index = 0
    }
}