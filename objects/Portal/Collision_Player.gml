if lockstep_stop
	exit

if close
	exit

other.depth = depth - 1
other.mask_index = mskNone
other.nexthurt = current_frame + 30

if endgame > 30 {
	close = true
	
	alarm[1] = 90
	
	var p = other.id
	
	if other.race == Race.Robot && GameCont.level >= PLAYER_LEVEL_MAX {
	    with (WepPickup) if (visible && ammo) {
			with (Player) if (race == Race.Robot) {
				scrRobotEat(other.wep, true)
			}
			
			snd_play_hit(sndRobotEat)
			ammo = false
		}
	}
	
	snd_play(sndPortalClose)
	endgame = 30
}

