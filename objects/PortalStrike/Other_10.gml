/// @description Start

if !visible
	exit

visible = false

alarm[0] = 3

snd_play(snd)

snd_stop(sndPortalStrikeLoop)

with SwipeBombingTutorial
	done = true