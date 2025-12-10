time = 0
team = team_player

spr_idle = sprShield
spr_disappear = sprShieldDisappear

creator = noone

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
	
	if scrUltraCheckPlayerRace(_player, Race.Crystal, UltraSkill.Juggernaut) {
		snd_play(sndCrystalJuggernaut)
    }
	else snd_play(sndCrystalShield)
}

sprite_index = spr_idle

walk = 0