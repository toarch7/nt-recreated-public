if lockstep_stop
	exit

if (close) exit

other.depth = depth - 1
other.mask_index = mskNone
other.nexthurt = current_frame + 30

if (endgame > 30) {
	close = true
	
	alarm[1] = 90
	
	if (scr_ultra_get_from_race(Race.Robot) != -1) {
		var _tb = scr_skill_get(mut_throne_butt)
		
	    with (WepPickup) if (visible && !curse) {
			with (Player) if (race == Race.Robot) {
				scrRobotEat(other.wep, true)
			}
			
			with (instance_create(x, y, RobotEat)) {
				if (_tb) sprite_index = sprRobotEatTB
			}
			
			instance_create(x, y, Smoke)
			ammo = false
		}
	}
	
	snd_play(sndPortalClose)
	endgame = 30
}
