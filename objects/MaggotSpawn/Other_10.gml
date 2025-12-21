event_inherited()

speed = 0

scrTarget()

if instance_exists(target) {
    if (point_distance(x, y, target.x, target.y) < 64
		&& sprite_index != spr_hurt && sprite_index != spr_chrg
	) {
        hp -= 1
        sprite_index = spr_chrg
        image_index = 0
    }
}