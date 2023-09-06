if lockstep_stop
	exit

if instance_exists(Drama) {
    with ScrapBoss {
        draw_sprite_ext(sprScrapBossIntro, - 1, x, y, right, 1, 0, c_white, 1)
        image_index += 0.4
    }
} else draw_sprite_ext(sprite_index, - 1, x, y, right, 1, 0, c_white, 1)