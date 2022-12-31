function snd_play_hit_big(argument0, argument1 = 0.2) {
    argument0 = custom_sound_check(argument0)

    if instance_exists(Player) dir = instance_nearest(x, y, Player)
    else dir = self
    if (GameCont.area == 101) {
        if ((argument0 == sndExplosion) || ((argument0 == sndExplosionL) || (argument0 == sndExplosionXL))) argument0 = sndOasisExplosion
        if (argument0 == sndExplosionS) argument0 = sndOasisExplosionSmall
    }
    audio_sound_pitch(argument0, ((1 + random(argument1)) - (argument1 / 2)))
    audio_stop_sound(argument0)
    audio_sound_gain(argument0, UberCont.mainvol, 0)
    if (dir == self) audio_play_sound_at(argument0, ((view_xview + (view_width / 2)) - x), ((view_yview + (view_height / 2)) - y), 0, 320, 64000, 1, false, 0)
    else audio_play_sound_at(argument0, (dir.x - x), (dir.y - y), 0, 320, 64000, 1, false, 0)



}