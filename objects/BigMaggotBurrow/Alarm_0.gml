ang = random_angle
var p = instance_nearest(x, y, Player)
if instance_exists(p) {
    if place_free(p.x + lengthdir_x(64, ang), p.y + lengthdir_y(64, ang)) and place_meeting(p.x + lengthdir_x(64, ang), p.y + lengthdir_y(64, ang), Floor) {
        snd_play(sndBigMaggotUnburrowSand)
        alarm[1] = 5 / 0.4
        //dust ring here plz
        x = p.x + lengthdir_x(64, ang)
        y = p.y + lengthdir_y(64, ang)
        image_index = 0
        sprite_index = sprBigMaggotAppear
        visible = 1
    } else alarm[0] = 1
}