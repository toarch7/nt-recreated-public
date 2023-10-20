if UberCont.opt_keyboard or UberCont.opt_gamepad exit

var a = 0,
    touch = event_data[? "touch"]

with MobileUI {
    if index == touch
		a = true
}

// ignore long touches or occupied ones
if a or (touch < 4 && UberCont.touch_duration[touch] > 10) {
    exit
}

var mx = event_data[? "guistartposX"],
	my = event_data[? "guistartposY"]

var cx = event_data[? "posX"],
	cy = event_data[? "posY"]

if point_distance(0, 0, event_data[? "diffX"], event_data[? "diffY"]) > 12 && my > 16 {
	with Player {
		if index != global.index
			continue
		
		if race == 12 && player_pref(playerinstance, "rogue") && !instance_exists_var(PortalStrike, "creator", id) {
            if rogue_ammo {
				KeyCont.activeforever[global.index] = true
				
				ButtonActive.rogue_touch = touch
				
                with instance_create(cx, cy, PortalStrike) {
                    self.touch = touch
                    creator = other.id
					
					event_perform(ev_step, 0)
                }
				
                rogue_ammo --
            }
			else if !snd_is_playing(sndPortalStrikeEmpty) {
                snd_play(sndPortalStrikeEmpty)
            }
        }
	}
}