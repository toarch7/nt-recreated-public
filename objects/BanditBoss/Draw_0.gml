if instance_exists(Drama) {
    with BanditBoss {
        draw_sprite_ext(sprite_index, - 1, x, y, right, 1, 0, c_white, 1)
        draw_sprite_ext(sprBanditBossGun, - 1, x - sin((gunangle / 180) * pi) * 8, y, 1, right, gunangle, c_white, 1)
        gunangle += 34
        image_index += 0.4
    }
} else {
    if gunangle <= 180 draw_sprite_ext(sprBanditBossGun, - 1, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, c_white, 1) draw_sprite_ext(sprite_index, - 1, x, y, right, 1, 0, c_white, 1)
    if gunangle > 180 draw_sprite_ext(sprBanditBossGun, - 1, x + lengthdir_x(-wkick, gunangle), y + lengthdir_y(-wkick, gunangle), 1, right, gunangle, c_white, 1)
}