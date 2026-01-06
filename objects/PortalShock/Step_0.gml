if lockstep_stop
	exit

with (damagesource) {
	if (team != team_player) instance_destroy(id, false)
}