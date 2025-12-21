/// @description Start

if (!visible) exit

visible = false

var _amount = ammo - 0.5
explo_x -= ldrx(size * 0.5, direction) * _amount
explo_y -= ldry(size * 0.5, direction) * _amount

event_perform(ev_alarm, 0)

snd_stop(sndPortalStrikeLoop)

with (SwipeBombingTutorial) done = true

snd_play(snd)