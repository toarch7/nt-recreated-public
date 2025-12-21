time = 0
team = team_player

spr_idle = sprShield
spr_disappear = sprShieldDisappear

creator = noone

teleporting = false
teleport_x = x
teleport_y = y

if instance_exists(Player) {
    var _player = instance_nearest(x, y, Player),
		_skin = _player.bskin
	
    if _skin == SkinLetter.B {
        spr_idle = sprShieldB
        spr_disappear = sprShieldBDisappear
    }
	else if _skin == SkinLetter.C {
		spr_idle = sprShieldC
        spr_disappear = sprShieldCDisappear
	}
	
	var _juggernaut = false
	
	if scr_player_ultra_get(_player, Race.Crystal, UltraSkill.Juggernaut) {
		snd_play(sndCrystalJuggernaut)
		_juggernaut = true
    }
	else snd_play(sndCrystalShield)
	
	for(var i = 0; i < 2 + _juggernaut; ++i) {
		repeat (5) with (instance_create(x, y, Dust)) {
			speed += 2 + i
			x += hspeed * 5
			x += vspeed * 4
			
			if (!place_meeting(x, y, Floor)) instance_destroy()
		}
	}
	
	scr_screenshake(5)
}

sprite_index = spr_idle

walk = 0