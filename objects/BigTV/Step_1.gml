if lockstep_stop
	exit

if !instance_exists(Cinematic) {
    event_inherited() exit
}

drawframe += 0.4