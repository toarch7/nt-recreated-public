if !instance_exists(Player) or GameCont.area == 106 exit

if snd_is_playing(Player.snd_spch) or snd_is_playing(Player.snd_thrn) {
    alarm[1] = 15 exit
} else snd_play(Player.snd_spch)