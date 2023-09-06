if lockstep_stop
	exit

if (!instance_exists(GenCont) && !instance_exists(NothingSpiral) && !instance_exists(LevCont)) {
    scrDrawSpiral()
}