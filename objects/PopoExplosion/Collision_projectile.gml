if lockstep_stop
	exit

if team != other.team && other.typ && !object_is_ancestor(other.object_index, Grenade) {
    with other instance_destroy()
}