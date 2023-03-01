if !instance_exists(Player) or GameCont.area == 106 exit

var p = instance_exists_var(Player, "is_me", 1)

if !p
	exit

if snd_is_playing(p.snd_spch) or snd_is_playing(p.snd_thrn) {
    alarm[1] = 15 exit
}
else snd_play(p.snd_spch)