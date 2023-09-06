if lockstep_stop
	exit

if instance_exists(GenCont) or instance_exists(LevCont) {
    alarm[4] = 300
}