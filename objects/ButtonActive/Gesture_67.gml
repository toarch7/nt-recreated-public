if UberCont.opt_keyboard or UberCont.opt_gamepad exit


var a = 0,
    touch = event_data[? "touch"]

    with MobileUI {
        if index == touch a = 1
    }

    // ignore long touches or occupied ones
if a or UberCont.touch_duration[touch] > 10 {
    exit
}

var mx = event_data[? "guistartposX"]
var my = event_data[? "guistartposY"]

var cx = event_data[? "posX"]
var cy = event_data[? "posY"]

if point_distance(0, 0, event_data[? "diffX"], event_data[? "diffY"]) > 12 && my > 16 {
    with Player
    if is_me {
        if race == 12 && !instance_exists(PortalStrike) {
            if rogue_ammo {
                with instance_create(cx, cy, PortalStrike) {
                    if !UberCont.opt_keyboard && !UberCont.opt_gamepad {
                        direction = point_direction(cx, cy, device_mouse_x(touch), device_mouse_y(touch))
                    }

                    self.touch = touch
                    creator = other.id
                }

                rogue_ammo--other.rogue_bombing = 1
            } else if !snd_is_playing(sndPortalStrikeEmpty) {
                snd_play(sndPortalStrikeEmpty)
            }
        }
    }
}